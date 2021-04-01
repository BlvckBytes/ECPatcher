from models.asl_file import AslFile
import sys

def main():
    inp_loc = 'test.dsl' if len(sys.argv) == 1 else sys.argv[1]
    file = AslFile(inp_loc)
    print(file.patch_regions())

if __name__ == '__main__':
    main()