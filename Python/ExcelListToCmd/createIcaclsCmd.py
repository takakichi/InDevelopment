#coding:utf-8
from jinja2 import Template

# icacls [ファイル名] /grant [ユーザー名]:[perm]
cmd_grant_file = "icacls {filename} "
cmd_deny_file = "icacls {} {} {}"
cmd_grant_dir = ""
cmd_deny_dir = ""

def createIcaclsCmd():
    print(cmd_grant_file)
    return 0