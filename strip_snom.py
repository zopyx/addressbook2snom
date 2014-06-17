import sys
import csv

filename = sys.argv[1]
filename2 = 'out_' + filename
with open(filename) as in_fp:
    with open(filename2, 'wb') as out_fp:
        reader = csv.reader(in_fp, delimiter=',')
        writer = csv.writer(out_fp, delimiter=',', quotechar='"')
        for line in reader:
            print line
            number = line[1]
            number = number.replace(' ', '')
            number = number.replace('/', '')
            number = number.replace('-', '')
            number = number.replace('(', '')
            number = number.replace(')', '')
            line[1] = number
            print line
            writer.writerow(line)
