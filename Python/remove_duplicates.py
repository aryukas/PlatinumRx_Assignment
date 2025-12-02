# to remove duplicate characters from string using loop

input_string = input("Enter a string: ")

unique_string = ""
for char in input_string:
    if char not in unique_string:
        unique_string += char

print("Unique string:", unique_string)
