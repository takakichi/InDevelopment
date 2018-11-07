#coding:utf-8
import pandas as pd

def readExcel(filename, sheetname):
    df_sheet_index = pd.read_excel(filename, sheet_name=sheetname)
    return 0
