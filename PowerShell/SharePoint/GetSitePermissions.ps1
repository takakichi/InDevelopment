################################################################################
#	File Get-SitePermissions
#	Title サイトの権限取得用 PowerShell スクリプト
#	Description SharePoint 2013 用サイトの権限の一覧を取得する PowerShell スクリプト
#	Created Kokuho Hi  SharePoint Technology Center
#	Copyright Copyright (C) 2015 Sonorite Co.,LTD. All rights reserved.
#	Update History
#	0.01 2015.02.11 作成開始
#	0.10 2015.02.11 プロトタイプ完成
# http://blog2nd.sharepoint-factory.net/article/113552129.html
################################################################################

# パラメータ定義
Param(
	[string]$Identity,
	[string]$ContentDatabase,
	[string]$WebApplication,
	[switch]$Allwebs
)

function Get-Permissions ($web)
{
	$results = @()

	foreach ($assignments in $web.RoleAssignments) {
		if ($assignments.Member.XML.StartsWith('Group') -eq True) {
			$type = SharePoint グループ
		} elseif ($assignments.Member.IsDomainGroup) {
			$type = ドメイン グループ
		} else {
			$type = ユーザー
		}
		$role = ($assignments.RoleDefinitionBindings  Select-Object -ExpandProperty name)
		$results += New-Object PSObject -Property @{
						Url = $web.Url;
						Name = $assignments.Member.Name;
						Type = $type;
						Role = $role
					}  Select-Object Url, Name, Type, Role
	}

	$results
}

# サイトの権限の取得
function Get-Site ($web)
{
	$results = @()
	$results += Get-Permissions ($web)

	if ($Allwebs) {
		foreach ($subweb in $web.webs) {
			$results += Get-Site ($subweb)
		}
	}

	$results
}

# サイトコレクション取得
function Get-SiteCollection ($sitecollection)
{
	$results = @()

	foreach ($site in $sitecollection) {
		$results += Get-Site ($site.rootweb)
	}

	Write-Output $results
}

# パラメータ処理
function Get-CommandLineOptions
{
	if ($Identity) {
		Get-SiteCollection (get-SPSite -Identity $Identity)
	} elseif ($ContentDatabase) {
		Get-SiteCollection (get-SPSite -ContentDatabase $ContentDatabase)
	} elseif ($WebApplication) {
		Get-SiteCollection (get-SPSite -WebApplication $WebApplication)
	}
}

# エントリーポイント
Get-CommandLineOptions

################################################################################
# End of Script
################################################################################