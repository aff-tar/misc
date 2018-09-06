import os
import csv
from datetime import datetime, date, time

path = './Fit/Daily Aggregations/'
files = os.listdir(path)
output = open('weight.csv', 'w')
height = 1.65
weight = 0
bmi = 0
has_weight = 0

output.write("Body\nDate,Weight,BMI,Fat\n")

for file_w_ext in files:
    date_string, ext = os.path.splitext(file_w_ext)
    with open(os.path.join(path, file_w_ext), 'r') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            if row['Average weight (kg)']:
            weight = float(row['Average weight (kg)'])
            has_weight = 1
        if has_weight:
            dt = datetime.strptime(date_string, "%Y-%m-%d")
            bmi = weight / (height * height)
            print("\"" + dt.strftime("%d-%m-%Y") + "\",\"{:.2f}\",\"{:.2f}\",\"0\"".format(weight, bmi))
            output.write("\"" + dt.strftime("%d-%m-%Y") + "\",\"{:.2f}\",\"{:.2f}\",\"0\"\n".format(weight, bmi))
        has_weight = 0

