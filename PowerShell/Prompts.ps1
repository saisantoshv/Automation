# @file Prompts.ps1
#
# @author Danko Adamczyk <dankoadamczyk@me.com>
# @version 1.0.0

# Ask a question.

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