################################################################################
#	File Get-SitePermissions
#	Title �T�C�g�̌����擾�p PowerShell �X�N���v�g
#	Description SharePoint 2013 �p�T�C�g�̌����̈ꗗ��擾���� PowerShell �X�N���v�g
#	Created Kokuho Hi  SharePoint Technology Center
#	Copyright Copyright (C) 2015 Sonorite Co.,LTD. All rights reserved.
#	Update History
#	0.01 2015.02.11 �쐬�J�n
#	0.10 2015.02.11 �v���g�^�C�v����
# http://blog2nd.sharepoint-factory.net/article/113552129.html
################################################################################

# �p�����[�^��`
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
			$type = SharePoint �O���[�v
		} elseif ($assignments.Member.IsDomainGroup) {
			$type = �h���C�� �O���[�v
		} else {
			$type = ���[�U�[
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

# �T�C�g�̌����̎擾
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

# �T�C�g�R���N�V�����擾
function Get-SiteCollection ($sitecollection)
{
	$results = @()

	foreach ($site in $sitecollection) {
		$results += Get-Site ($site.rootweb)
	}

	Write-Output $results
}

# �p�����[�^����
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

# �G���g���[�|�C���g
Get-CommandLineOptions

################################################################################
# End of Script
################################################################################