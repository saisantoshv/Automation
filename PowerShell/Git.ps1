# @file Git.ps1
*
* @author Danko Adamczyk <dankoadamczyk@me.com>
* @version 1.0.0

# Easily create a branch and push it to the origin.

function cb(){

    param(
		[Parameter(Mandatory = $TRUE)] [ValidateNotNullOrEmpty()]
			[String] $Branch,
		[String] $Base = 'develop'
	)   

    git co $Base
    git pull
    git co -b $Branch
    git push --set-upstream origin $Branch
}