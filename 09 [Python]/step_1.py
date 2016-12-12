import sys;

string = ""
if len(sys.argv) > 1:
    content = sys.argv[1]
else:
    with open('input.txt', 'r') as content_file:
        content = content_file.read()

while True:
    result = content.partition("(")
    string += result[0]
    rest = result[2]
    result = rest.partition('x')
    if len(rest) == 0:
        break
    chars = int(result[0])
    rest = result[2]
    result = rest.partition(')')
    multiplier = int(result[0])
    rest = result[2]
    to_multiply = rest[:chars]
    string += to_multiply * multiplier
    if len(rest) == 0:
        break
    content = rest[chars:].strip()

print(len(string))
