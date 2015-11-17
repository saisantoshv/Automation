# @file Prompts.ps1
#
# @author Danko Adamczyk <dankoadamczyk@me.com>
# @version 1.0.0

# Ask a question.

<#
.SYNOPSIS
Ask a question and return response when it matches to one of the @Options.

.DESCRIPTION
ask 'Do you want to continue?' @('Y', 'n') 'n'
Known bug. The @Default param does not seem to work..

.NOTES
#>

function ask{

    param(
		[String] $Question = 'Do you want to continue?',
        $Options = @('Y', 'n'),
        $Default = 'n'
	)

    while($response -notin $Options){

        $Choices = [string]::join("/", $Options)
        $response = Read-Host -Prompt "$Question [$Choices default = $Default]"

        if($response -eq ''){

            $response = $Default
        }
	}

    return $response
}