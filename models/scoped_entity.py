class ScopedEntity:

  def __init__(self, lines):
    self.lines = lines
    self.caluclate_indent_width()

  def caluclate_indent_width(self):
    # Loop all lines until a line with indent > 0 has been encountered
    for i in self.lines:
      curr_indent = len(self.lines[i]) - len(self.lines[i].lstrip(' '))

      # Keep a hold of the file's indent width in spaces, terminate loop
      if curr_indent > 0:
        self.indent_width = curr_indent
        break
  
  def find_scope(self, line_number):
    curr_indent = len(self.lines[line_number]) - len(self.lines[line_number].lstrip(' '))
    scope = []
    for i in range(line_number, 0, -1):
      line = self.lines[i]
      line_indent = len(line) - len(line.lstrip(' '))

      if curr_indent - line_indent != self.indent_width:
        continue

      line = line.strip()

      if 'Scope (' in line:
        scope.append(line[7:len(line) - 1])
      elif 'Device (' in line:
        scope.append(line[8:len(line) - 1])
      else:
        continue

      curr_indent = line_indent

    return scope[::-1]