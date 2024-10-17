import csv

fileName ="Performance"


with open(f"KATZENJAMMER-build-{fileName}.sql", 'w') as output:
    # output.write("-- Khush Khgrewal@calpoly.edu\n")
    with open(fileName+'.csv', 'r') as file:
        csv_reader = csv.reader(file)
        header = next(csv_reader)
        for row in csv_reader:
            output.write("INSERT INTO "+"KATZENJAMMER_performance"+" (")
            for value in header[:-1]:
                output.write(''+value.strip("\'")+', ')
            value2 = header[-1].strip("'")
            output.write(f"{value2})\nVALUES (")
            for value in row[:-1]:
                output.write(value+', ')
            output.write(f"{row[-1]});\n\n")