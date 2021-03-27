from models.operation_region import OperationRegion

# Read file
with open('DSDT.dsl', 'r') as f:

  # Create dict of line_number -> line_content
  lines = dict((num, line) for num, line in enumerate(f.readlines()))

  # Search for region-definitions on the EC-memory
  regDefs = dict(filter(lambda x: "OperationRegion" in x[1] and "EmbeddedControl" in x[1], lines.items()))

  # Generate patch for operationregions, summarize as far as possible
  # Colliding offsets and different field-block properties need to be split up separately
  # Thus, first of group by Acc, Lock and Preserve and then split on duplicate offsets

  for x in regDefs:
    OperationRegion(x, lines)