from models.field import Field
import math

class FieldBlock:

  def __init__(self, line_index, initial_offset, lines):
    self.lines = lines
    self.initial_offset = initial_offset

    self.parse_def_str(line_index)
    self.parse_fields(line_index + 2)

  def parse_def_str(self, line_index):
    # Parse data from syntax, limited by () delimited by ,
    defStr = self.lines[line_index].strip()
    data = defStr[defStr.index('(') + 1:defStr.index(')')].split(', ')

    # Store properties
    self.field_name = data[0]
    self.acc = data[1]
    self.lock = data[2]
    self.preserve = data[3]

  def parse_fields(self, first_line):
    self.fields = []

    # Bit-counter for fields smaller than 8b, will get collapsed into offset
    curr_bits = 0

    # Current offset, starting out with the parent region's initial offset
    curr_offset = self.initial_offset

    # Loop till EOF
    for i in range(first_line, len(self.lines)):
      curr = self.lines[i]

      # Stop at closing bracket of block
      if curr.strip() == '}': break

      # Apply offset instruction and reset bit counter
      if 'Offset (' in curr:
        curr_offset = int(curr[curr.index('(') + 1:curr.index(')')], 16)
        curr_bits = 0
        continue
      
      # Create field, only keep track of it if it has a name
      f = Field(curr_offset, i, self.lines)
      if (f.name != ''):
        self.fields.append(f)
      
      # Add past field's size to offset, keep track of remainder
      curr_offset = curr_offset + math.floor(f.size / 8)
      curr_bits = curr_bits + f.size % 8

      # Collapse bit-counter if applicable
      if curr_bits / 8 >= 1:
        off_bytes = math.floor(curr_bits / 8)
        curr_bits = curr_bits - off_bytes * 8
        curr_offset = curr_offset + off_bytes