from models.operation_region import OperationRegion
from models.field import Field
from models.field_block import FieldBlock

import re
import math

class AslFile:

  def __init__(self, path):
    self.path = path

    self.read_content()
    self.parse_regions()

  def read_content(self):

    # Open file at path readonly
    with open(self.path, 'r') as f:
      lines = f.readlines()

      # Strip all comments, since they have no purpose for this application
      lines = self.strip_comments(lines)

      # Create dict of line_number -> line_content
      self.lines = dict((num, line) for num, line in enumerate(lines))

  def strip_comments(self, lines):
    processed_lines = []
    skip_until = -1
    for line_info in enumerate(lines):
      
      # Ignore lines from previous results
      if skip_until >= line_info[0]:
        continue

      line = line_info[1]

      # Eliminate all single-line comments
      line = re.sub(r'\/\/.*', '', line)

      # Eliminate all block comments in a single line
      if '/*' in line and '*/' in line:
        line = re.sub(r'\/\*(.|[\r\n])*?\*\/', '', line)

      # Block comment opened up in this line
      elif '/*' in line:
        line = line[0:line.index('/*')]

        # Loop until end of block comment has been found
        for i in range(line_info[0] + 1, len(lines)):
          line_i = lines[i]

          # End of block comment
          if '*/' in line_i:
            remains = line_i[line_i.index('*/') + 2:len(line_i)]
            
            # If there is any code after this closing tag, append it
            if remains.strip() != '':
              processed_lines.append(line)

            # Set skip tracker to skip all lines that were this block comment
            skip_until = i
            break

      # Only append lines with actual content
      if line.strip() != '':
        processed_lines.append(line)

    return processed_lines

  def get_all_fields(self, region):
    # Get all exising field names from EC-regions
    ec_field_names = []
    for region in self.regions:
      for block in region.blocks:
        for field in block.fields:
          ec_field_names.append(field.name)

    return ec_field_names

  def parse_regions(self):
    # Search for region-definitions on the EC-memory
    reg_defs = dict(filter(lambda x: "OperationRegion" in x[1] and "EmbeddedControl" in x[1], self.lines.items()))

    # Map line numbers to new operationregion instances
    self.regions = []
    for reg_def in reg_defs:
      try:
        reg = OperationRegion(reg_def, self.lines)

        # filter out empty regions
        if len(reg.blocks) > 0:
          self.regions.append(reg)
      except ValueError:
        print('[WARNING] Unparsable EC-OR encountered! (check if it needs patching manually)')
        print('[WARNING] ' + self.lines[reg_def].strip())

  def patch_regions(self):
    # Get all field names to avoid collisions
    ec_field_names = self.get_all_fields(self.regions)

    # Target name of override region, EPCH for EmbeddedControlPatch, should be fairly unique...
    target_name = "EPCH"

    # Generate patch for operationregions, summarize as far as possible
    # Colliding offsets and different field-block properties need to be split up separately
    blocks = self.generate_patch_blocks(self.regions, target_name, ec_field_names)

    # Add indexfield-blocks to field-blocks
    # NOTE: I don't yet know whether or not this is even needed...
    blocks = blocks + self.find_index_fields(self.lines, ec_field_names)

    # Generate the region patch code from previously created patch-blocks
    region_patch = self.generate_region_patch(blocks, target_name)
    return region_patch

  def patch_field(self, field, dest, names):
    byte_size = math.floor(field.size / 8)

    # Only patch fields with a 2- or 4 times multiple of 8
    # Greater sizes are taken care of differently
    if byte_size != 2 and byte_size != 4:
      dest.fields.append(field)
      return

    # A field name is four letters in size, try all combinations except 0
    subfields = []
    for i in range(1, 4):

      # Try to create all sub-fields without name collisions
      for j in range(0, byte_size):
        # Create new name by changing character at i to j
        curr_name = field.name[:i] + str(j) + field.name[i + 1:]

        # Collision, stop the loop
        if len(list(filter(lambda x: x == curr_name, names))) != 0:
          subfields = []
          break

        # Create subfield
        subfield = Field(field.offset + j, -1, [])
        subfield.name = curr_name
        subfield.size = 8
        subfield.former_name = field.name

        # Append subfield
        names.append(subfield.name)
        subfields.append(subfield)

      # Process was successful, no further trials required
      if len(subfields) == byte_size:
        break

    # Not successful, even after all four tries, exit the program
    if len(subfields) != byte_size:
      print(f'Could not create subfields for field {field.name} without name-collisions!')
      sys.exit()

    dest.fields = dest.fields + subfields
    return

  def generate_patch_blocks(self, regions, target_name, names):
    # Created blocks containing patched fields
    blocks = []

    for region in regions:
      for block in region.blocks:
        # Find available blocks from block dict, based on same signature as current block
        av_blocks = list(filter(lambda x: x.has_same_signature(block), blocks))
        
        # Loop current block's fields
        for field in block.fields:

          # Skip fields already smaller than 8b or not in use at all
          if field.size <= 8 or not field.is_in_use():
            continue
          
          # Find applicable block
          success = False
          for av_block in av_blocks:

            # This block already contains a field at the same offset
            if len(list(filter(lambda x: x.offset == field.offset, av_block.fields))) != 0:
              continue

            # Block works out, patch and append
            self.patch_field(field, av_block, names)
            success = True
            break

          # No block found, create a new copy, patch and append
          if not success:
            copy = block.clone_empty(target_name)
            self.patch_field(field, copy, names)
            av_blocks.append(copy)
            blocks.append(copy)

    # Sort every block's fields by ascending offsets
    for block in blocks:
      block.fields.sort(key=lambda x: x.offset)

    return blocks

  def generate_region_patch(self, blocks, target_name):
    # Indentation for output
    indent = '    '

    # Scope
    patch = f'Scope ({".".join(blocks[0].scope)})' + '\n{\n'

    # Region definition, full size of 0x0->0xFF
    patch = patch + f'{indent}OperationRegion ({target_name}, EmbeddedControl, Zero, 0xFF)'

    # Loop blocks
    for block in blocks:

      # Append field-block definition, with it's properties
      if block.index_name is None:
        patch = patch + f'\n{indent}Field ({target_name}, {block.access_type}, {block.lock_rule}, {block.update_rule})\n'

      # Append indexfield-block definition, with it's properties
      else:
        patch = patch + f'\n{indent}IndexField ({block.index_name}, {block.field_name}, {block.access_type}, {block.lock_rule}, {block.update_rule})\n'

      patch = patch + indent + '{\n'
      
      # Loop fields
      curr_offset = None
      for f in block.fields:

        # Only append offset instruction if offset would not be redundant
        if curr_offset == None or curr_offset + 1 != f.offset:
          patch = patch + f'{indent * 2}Offset (0x{f.offset:x}),\n'

          # Append field with it's offset and former name (if exists)
          if f.former_name is not None:
            patch = patch + f'{indent * 2}// Former: {f.former_name}\n'

        # Else append the offset as a comment, helpful for patching
        else:
          patch = patch + f'{indent * 2}// Offset: (0x{f.offset:x})'
          
          # Append field with it's offset and former name (if exists)
          if f.former_name is not None:
            patch = patch + f', former: {f.former_name}\n'
          else:
            patch = patch + '\n'

        patch = patch + f'{indent * 2}{f.name}, {f.size},\n'
        curr_offset = f.offset

      # Remove last trailing comma
      patch = patch.rstrip()[:-1] + '\n' + indent + '}\n'

    patch = patch + '}'
    return patch

  def find_index_fields(self, lines, ec_field_names):
    # Search for index-field definitions
    index_field_defs = dict(filter(lambda x: f'IndexField (' in x[1], lines.items()))

    # Map line numbers to fieldblocks
    index_fields = list(map(lambda x: FieldBlock(x, 0, None, lines), index_field_defs))

    # Only return index-fields that have their name and index within EC space
    return list(filter(lambda x: x.index_name in ec_field_names and x.field_name in ec_field_names, index_fields))