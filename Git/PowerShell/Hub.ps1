# @file Hub.ps1
#
# @author Danko Adamczyk <dankoadamczyk@me.com>
# @version 1.0.1
# For these commands you need to have https://hub.github.com/ installed.

. (Resolve-Path (Join-Path $PSScriptRoot "..\..\PowerShell\Prompts.ps1"))

<#
.SYNOPSIS
Create a pull request from the active branch.

.DESCRIPTION
pr develop
For these commands you need to have the Hub library installed

.LINK
https://hub.github.com/
#>

function pr{

    param(
		[String] $BaseBranch = 'develop'
	)

    if((ask 'Do you want to create a Pull Request based on an existing issue?' @('Y', 'n') 'n') -eq 'y'){

        hub issue;

        $Issue = Read-Host -Prompt 'Please provide an issue number or press [s] to stop'

        if ($Issue -eq 's'){

            RETURN
        }

        if ($issue -gt 0){
        
            hub pull-request -b $BaseBranch -i $Issue
        }
    }
    elseif((ask 'Do you want to create a new Pull Request?' @('Y', 'n') 'n') -eq 'y'){

        hub pull-request -b $BaseBranch
    }
    else{

        RETURN
    }

    if((ask 'Do you want to view the branch on GitHub??' @('Y', 'n') 'y') -eq 'y'){

        # TODO: It would be great if we can directly access the PR instead of the branch.
        hub browse
    }
}