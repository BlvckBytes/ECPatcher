from models.field import Field
from models.scoped_entity import ScopedEntity
import math

class FieldBlock:

  def __init__(self, line_index, initial_offset, scope, lines):
    self.fields = []
    self.lines = lines
    self.index_name = None
    self.scope = scope
    self.initial_offset = initial_offset

    if self.scope == None:
      self.scope = ScopedEntity(lines).find_scope(line_index)

    # Used for manual property assignment
    if line_index < 0:
      return

    self.parse_def_str(line_index)
    self.parse_fields(line_index + 2)

  def parse_def_str(self, line_index):
    # Parse data from syntax, limited by () delimited by ,
    defStr = self.lines[line_index].strip()
    data = defStr[defStr.index('(') + 1:defStr.index(')')].split(', ')

    # Field offset is one, if it's an index field (different notation)
    f_off = 0
    if defStr.startswith('IndexField'):
      self.index_name = data[0]
      f_off = 1

    # Store properties
    self.field_name = data[0 + f_off]
    self.access_type = data[1 + f_off]
    self.lock_rule = data[2 + f_off]
    self.update_rule = data[3 + f_off]

  def parse_fields(self, first_line):
    # Bit-counter for fields smaller than 8b, will get collapsed into offset
    curr_bits = 0

    # Current offset, starting out with the parent region's initial offset
    curr_offset = self.initial_offset

    # Loop till EOF
    for i in range(first_line, len(self.lines)):
      curr = self.lines[i].strip()

      # Stop at closing bracket of block
      if curr == '}': break

      # Apply offset instruction and reset bit counter
      if 'Offset (' in curr:
        curr_offset = int(curr[curr.index('(') + 1:curr.index(')')], 16)
        curr_bits = 0
        continue
      
      # Create field, only keep track of it if it has a name
      f = Field(curr_offset, i, self.lines)
      if (f.name != '' and f.size >= 8):
        self.fields.append(f)
      
      # Add past field's size to offset, keep track of remainder
      curr_offset = curr_offset + math.floor(f.size / 8)
      curr_bits = curr_bits + f.size % 8

      # Collapse bit-counter if applicable
      if curr_bits / 8 >= 1:
        off_bytes = math.floor(curr_bits / 8)
        curr_bits = curr_bits - off_bytes * 8
        curr_offset = curr_offset + off_bytes

  def has_same_signature(self, other):
    return self.access_type == other.access_type and self.lock_rule == other.lock_rule and self.update_rule == other.update_rule and self.scope == other.scope

  def clone_empty(self, name):
    # Generate new empty block
    block = FieldBlock(-1, 0, self.scope, [])

    # Copy properties
    block.field_name = name
    block.access_type = self.access_type
    block.lock_rule = self.lock_rule
    block.update_rule = self.update_rule
    return block