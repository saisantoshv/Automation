# @file Git.ps1
#
# @author Danko Adamczyk <dankoadamczyk@me.com>
# @version 1.0.0

<#
.SYNOPSIS
Easily create a branch and push it to the origin.
#>

function cb(){

    param(
		[Parameter(Mandatory = $TRUE)] [ValidateNotNullOrEmpty()]
			[String] $NewBranch,
		[String] $BaseBranch = ''
	)   

    if($BaseBranch -ne ''){

        git co $BaseBranch
    }

    git pull
    git co -b $NewBranch
    git push --set-upstream origin $NewBranch
}