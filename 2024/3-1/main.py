import re

with open("input.txt") as f:
    content = f.read()

matches = re.findall(r"mul\((\d{1,3}),(\d{1,3})\)", content)
sum = 0
for match in matches: 
    sum += int(match[0])*int(match[1])

print(sum)
