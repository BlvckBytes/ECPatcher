class Field:

  def __init__(self, offset, line_index, lines):
    self.lines = lines
    self.offset = offset

    self.parse_def_str(line_index)

  def parse_def_str(self, line_index):
    # Parse data from syntax, delimited by ,
    data = self.lines[line_index].split(',', 2)

    # Store properties
    self.name = data[0].strip()
    self.size = int(data[1].strip())