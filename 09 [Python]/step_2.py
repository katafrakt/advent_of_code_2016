import sys;

def parse(string):
    strlen = 0
    result = string.partition("(")
    strlen += len(result[0])
    rest = result[2]
    result = rest.partition('x')
    if len(result[2]) == 0:
        return strlen
    chars = int(result[0])
    rest = result[2]
    result = rest.partition(')')
    multiplier = int(result[0])
    rest = result[2]
    strlen += multiplier * parse(rest[:chars]) + parse(rest[chars:])
    return strlen

strlen = 0
if len(sys.argv) > 1:
    content = sys.argv[1]
else:
    with open('input.txt', 'r') as content_file:
        content = content_file.read()

strlen += parse(content)

print(strlen)
