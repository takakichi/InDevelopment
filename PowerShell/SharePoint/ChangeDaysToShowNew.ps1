#
# 新着アイコン表示日数の変更
# https://84log.xii.jp/2016/11/24/442

function ChangeDaysToShowNew( [string] $website, $days ) {
  $WebApp = Get-SPWebApplication $website
  # 0で設定すると非表示になる
  $WebApp.DaysToShowNewIndicator = $days
  $WebApp.Update()
}

#
# 新着アイコン表示日数の表示
# https://84log.xii.jp/2016/11/24/442
#
function ShowDaysToShowNew( [string] $website ) {
  $WebApp = Get-SPWebApplication $website
  $WebApp.DaysToShowNewIndicator
}

ShowDaysToShowNew "http://SharePointWebAppURL/"
ShowDaysToShowNew "http://SharePointWebAppURL/" 10   # 新着アイコン表示日数を10日に変更
ShowDaysToShowNew "http://SharePointWebAppURL/" 0    # 新着アイコン表示を非表示にする
