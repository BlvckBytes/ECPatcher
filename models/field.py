import re

class Field:

  def __init__(self, offset, line_index, lines):
    self.lines = lines
    self.line_index = line_index
    self.offset = offset
    self.former_name = None

    # Used for manual property assignment
    if line_index < 0:
      return

    self.parse_def_str()

  def parse_def_str(self):
    # Parse data from syntax, delimited by ,
    data = self.lines[self.line_index].split(',', 2)

    # Store properties
    self.name = data[0].strip()
    self.size = int(data[1].strip())

  def usage_filter(self, line, curr_index):
    # Field name is either former name if exists, or actual name (for non-splitted fields)
    field_name = self.former_name if self.former_name else self.name

    # Not even inside this line, or same line as definition
    if field_name not in line or curr_index == self.line_index:
      return False

    # Pattern to (hopefully) only find actual usages and comments
    # Needs to have either non-alphanumeric or line-start at head and
    # non-aplhanumeric or line-end at tail, then it can only be a comment or an invocation
    # Everything around that is irrelevant to the search, thus .*
    p = re.compile(r'.*(([^A-Za-z0-9_\r\n]{1}|^)' + field_name + r'([^A-Za-z0-9_\r\n]{1}|$)).*')

    # Ignore definitions
    def_stmts = ['Method (', 'Field (', 'OperationRegion (', 'Name (', 'Mutex (']
    no_def = not any([f'{def_stmt}{field_name}' in line for def_stmt in def_stmts])

    return p.match(line) and no_def

  def is_in_use(self):
    # It is in use, if there are any usages of this field
    uses = list(filter(lambda x: self.usage_filter(x[1], x[0]), self.lines.items()))
    return len(uses) > 0