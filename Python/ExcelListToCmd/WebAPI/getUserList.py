#coding:utf-8

userInfoList = []

#
# ユーザ管理クラス
#
class userInfo:
    def __init__(self, no, name, code, job):
        self.no = no
        self.name = name
        self.code = code
        self.job = job

#
# データを取得する
#
def getUserList():
    return 0

#
# テストデータを設定する
#
def getTestData():
    userInfoList.append( userInfo(no='000000', name='Tom',   code='001', job='artist') )
    userInfoList.append( userInfo(no='000010', name='John',  code='002', job='student') )
    userInfoList.append( userInfo(no='000020', name='Lisa',  code='002', job='artist') )
    userInfoList.append( userInfo(no='000030', name='Bob',   code='001', job='policeman') )
    userInfoList.append( userInfo(no='000040', name='Berry', code='001', job='fireman') )
    return 0

# テストコード
# getTestData()
# for userInfo in userInfoList:
#   print( userInfo.no + ',' + userInfo.name + ',' + userInfo.code + ',' + userInfo.job )
# found = [s for s in userInfoList if '000010' in s.no]
# print( found[0].name )

