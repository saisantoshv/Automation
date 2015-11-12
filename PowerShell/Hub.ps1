# @file Git.ps1
*
* @author Danko Adamczyk <dankoadamczyk@me.com>
* @version 1.0.0

# Ask a question.

function ask{

    param(
		[String] $Question = 'Do you want to continue?',
        $Options = @('Y', 'n'),
        $Default = 'n'
	)

    while($response -notin $Options){
        
        $Choises = [string]::join("/", $Options)
        $response = Read-Host -Prompt "$Question [$Choises default = $Default]"

        if($response -eq ''){

            $response = $Default
        }
	}

    return $response
}

# Create a Pull Request.

function pr{

  if((ask('Do you want to create an Pull Request based on an existing issue?')) -eq 'y'){

    hub issue;

    $Issue = Read-Host -Prompt 'Please provide an issue number or press [s] to stop'

    if ($Issue -eq 's'){

        RETURN
    }

    if ($issue -gt 0){
        
        hub pull-request -b develop -i $Issue
        RETURN
    }
  }

  if((ask('Do you want to create a new Pull Request?')) -eq 'y'){

    hub pull-request -b develop
    RETURN
  }
}