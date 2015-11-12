# @file Directory.ps1
#
# @author Danko Adamczyk <dankoadamczyk@me.com>
# @version 1.0.0

# Get the current folder.

function getFolder(){

    return Split-Path -leaf -path (Get-Location);
}