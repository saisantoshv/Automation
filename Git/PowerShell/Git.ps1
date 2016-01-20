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

    git pull --ff-only
    git co -b $NewBranch
    git push --set-upstream origin $NewBranch
}

<#
.SYNOPSIS

Prune the branches and delete already merged branches.
#>

function prune{
    
    & git remote prune origin
	& git branch --merged | ?{-not $_.trim().indexOf("*") -eq 0} | %{
        
        & git branch -d $_.trim()
    }    
}

<#
.SYNOPSIS
Clean this repository and remove already merged branches.
#>

function Clean-Repo{

	param(
		$branch = 'develop'
	)

    & git status 2>&1 | Out-Null

    if($LastExitCode -ne 0){
    
        Pop-Location
        return
    }

    $Folder = (Get-Item -Path ".\" -Verbose).BaseName;

    '{0}: Starting to clean on branch {1}' -f $Folder, $branch | Write-Host -ForegroundColor White

        
    & git fetch --all 2>&1 | Out-Null
    if($LastExitCode -ne 0){

        '{0}: unable to fetch. Investigate and re-run this script.' -f $Folder | Write-Host -ForegroundColor Red
        Pop-Location
        return
    }

    & git checkout $branch 2>&1 | Out-Null
    if($LastExitCode -ne 0){

        '{0}: unable to checkout {1}. Investigate and re-run this script.' -f $Folder, $branch | Write-Host -ForegroundColor Red
        Pop-Location
        return
    }

    $Status = (& git status)
    $BranchStatus = $Status[1]

    if($BranchStatus -like "Your branch is up-to-date with 'origin/$branch'."){

        prune
        '{0}: {1}' -f $Folder, $BranchStatus | Write-Host -ForegroundColor Green
        Pop-Location
        return
    }

    & git pull --ff-only 2>&1 | Out-Null
    if($LastExitCode -ne 0){

        '{0}: unable to pull {1}. Investigate and re-run this script.' -f $Folder, $branch | Write-Host -ForegroundColor Red
        Pop-Location
        return
    }
        
    $Status = (& git status)
    if($Status[2] -notlike 'nothing to commit, working directory clean' -and $Status[3] -notlike 'nothing to commit, working directory clean' ){

        '{0}: Investigate and re-run this script.' -f $Status | Write-Host -ForegroundColor Red
        Pop-Location
        return
    }

    prune
    '{0}: Done.' -f $Folder | Write-Host -ForegroundColor Green
}

<#
.SYNOPSIS
Iterate over all folders and call CleanRepo
#>

function Clean-Repos{

	param(
		$branch = 'develop'
	)

    Get-ChildItem . | %{

        Push-Location $_.FullName;
        Clean-Repo -branch $branch
        Pop-Location
    }
}