import os
import glob
import pandas as pd

# https://handyman.dulare.com/parse-multiple-sites-iis-logs-with-python/

sourceDir="T:\\IISLogFiles"

log_field_names = ['date', 'time', 's-ip', 'cs-method', 'cs-uri-stem', 'cs-uri-query', 's-port', 'cs-username', 'c-ip',
                   'cs(User-Agent)', 'cs(Referer)', 'sc-status', 'sc-substatus', 'sc-win32-status', 'time-taken']

df = pd.DataFrame()

# ---------------------------------------------------------
#
# ---------------------------------------------------------
for dirname, dirnames, filenames in os.walk(sourceDir):
    for subdirname in dirnames:
        list_of_files = glob.glob(sourceDir + "\\" + subdirname + "\\*.log")

        if len(list_of_files) > 0:
            latest_file = max(list_of_files, key=os.path.getctime)
            df_temp = pd.read_csv(latest_file, sep=' ', comment='#', engine='python', names=log_field_names)
            df_temp["website"] = subdirname
            df = df.append(df_temp, ignore_index=True)

