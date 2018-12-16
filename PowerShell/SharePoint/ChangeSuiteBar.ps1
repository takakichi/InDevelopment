#
#
# 元に戻す場合は、""を設定する
#
$web = Get-SPWebApplication "http://sharepointserver:xxxx"
$web.SuiteNavBrandingLogoNavigationUrl = "http://<リンク先URL>"
$web.SuiteNavBrandingLogoTitle = "画面表示名"
# $web.SuiteNavBrandingLogoUrl=""  # イメージを変更したい場合は SuiteNavBrandingLogoUrl に値をセットする
$web.Update()
