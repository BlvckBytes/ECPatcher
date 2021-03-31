from models.field_block import FieldBlock

class OperationRegion:

  def __init__(self, line_index, lines):
    self.lines = lines

    self.parse_def_str(line_index)
    self.find_field_defs()

  def parse_def_str(self, line_index):
    # Parse data from syntax, limited by () delimited by ,
    defStr = self.lines[line_index].strip()
    data = defStr[defStr.index('(') + 1:defStr.index(')')].split(', ')

    # Store properties
    self.field_name = data[0]
    self.offset = int(self.convert_literal(data[2]), 16)
    self.length = int(self.convert_literal(data[3]), 16)

  def find_field_defs(self):
    # Search for field-block definitions, corresponding to the region's field name
    blockDefs = dict(filter(lambda x: f'Field ({self.field_name}' in x[1], self.lines.items()))

    # Map line numbers to new fieldblock instances, filter out empty blocks
    self.blocks = list(map(lambda x: FieldBlock(x, self.offset, self.lines), blockDefs))
    self.blocks = list(filter(lambda x: len(x.fields) > 0, self.blocks))

  # Convert known literals to their digit representation
  def convert_literal(self, inp):
    if inp == 'Zero': return '0'
    if inp == 'One': return '1'
    return inp

