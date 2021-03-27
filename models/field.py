class Field:

  def __init__(self, offset, line_index, lines):
    self.lines = lines
    self.offset = offset
    self.former_name = None

    # Used for manual property assignment
    if line_index < 0:
      return

    self.parse_def_str(line_index)

  def parse_def_str(self, line_index):
    # Parse data from syntax, delimited by ,
    data = self.lines[line_index].split(',', 2)

    # Store properties
    self.name = data[0].strip()
    self.size = int(data[1].strip())

  def is_in_use(self):
    usages = list(filter(lambda x: self.former_name if self.former_name else self.name in x[1], self.lines.items()))
    return len(usages) > 1