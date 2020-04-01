import csv
import openpyxl


def w_file(results):
    resultsfilepath = 'results.csv'

    with open(resultsfilepath, 'a') as csvfile:
        writer = csv.writer(csvfile, delimiter=',')
        writer.writerow(results)


def x_file(results):
    #path to file
    resultsfilepath = 'results.xlsx'

    #open and get max row
    wb = openpyxl.open(resultsfilepath)
    sheet = wb.active
    max_row = sheet.max_row
    print(max_row)

    #convert to a string
    stuff = [results]

    #append new row to sheet
    for result in stuff:
        sheet.append(result)
        wb.save(filename=resultsfilepath)
    wb.close()
