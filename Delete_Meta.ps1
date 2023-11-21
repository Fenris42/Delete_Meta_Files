#Searches for and deletes Unity .meta extension files in current directory and its sub directories

try{

#Functions //////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Question{

    Param($Prompt)

    do{
    
        #promp user for input
        Write-Host ""
        Write-Host $Prompt
        $answer = Read-Host "[Y/N]"

        #verify if valid answer
        $answer = $answer.ToLower()

        if($answer -eq "y" -or $answer -eq "n"){
        
            #input valid, exit loop
            break
        
        }
        else{
        
            #input invalid. error and reprompt user
            Write-Host ""
            Write-Host "[Error]: " -ForegroundColor Red -NoNewLine; Write-Host "Invalid Entry. Only [Y/N] Accepted"
        }
    }
    while($true)

    return $answer
}

function SearchFiles{

    Param($Path)

    #console output
    Write-Host ""
    Write-Host "Searching for Files:"
    Write-Host ""

    #get all files in current directory and sub directories
    $allFiles = Get-ChildItem -Path $Path -Name -Recurse
    $metaFiles = New-Object System.Collections.ArrayList

    #loop through files
    foreach($file in $allFiles){
        
        #filter files for .meta files only
        if($File.EndsWith(".meta")){
            
            #console output found files
            Write-Host "[Found]: $Path\$file"

            #add files to search results
            [void]$metaFiles.Add("$Path\$file")
            $fileCount += 1
        }
    }

    #console output
    Write-Host ""
    Write-Host "$fileCount Files Found"

    if($fileCount -eq 0){
        
        #no files found, exit script
        Write-Host
        Write-Host "Nothing to delete in directory"

        ExitScript
    }
    else{
        
        #return search results
        return $metaFiles
    }

}

function DeleteFiles{

    Param($Files)

    #console output
    Write-Host ""
    Write-Host "Deleting Files:"
    Write-Host ""
    
    #loop through files
    foreach($file in $Files){
        
        #delete file
        Remove-Item -LiteralPath $file

        #console ouptut deleted file
        Write-Output "[Deleted]: $file"
        $fileCount += 1
    }

    #console output
    Write-Host ""
    Write-Host "$fileCount Files Deleted"
    
    ExitScript
}

function Abort{
    
    #console output
    Write-Host ""
    Write-Host "Aborted" -ForegroundColor Red

    ExitScript
}

function ExitScript{
    
    #output
    Write-Host ""
    Read-Host "Press any key to exit"
    Exit
}





# Main /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#get current directory
$path = Get-Location

#Search for Files //////////
$answer = Question -Prompt "Search for .meta files in $path ?"

#user accepted search
if($answer -eq "y"){
    
    $searchResults = SearchFiles -Path $path
}
#user did not accept, exit
else{
    
    Abort
}



#Delete Files //////////
$answer = Question -Prompt "Delete all .meta files found?"

#user accepted delete
if($answer -eq "y"){
    
    DeleteFiles -Files $searchResults
}
#user did not accept, exit
else{
    
    Abort
}

ExitScript



#Error Handling ///////////////////////////////////////////////////////////////////////////////////////////////////////
}catch{
    
    #something errored out during run. display error and exit
    Write-Host ""
    Write-Host "[Error]: " -ForegroundColor Red -NoNewLine; Write-Host "Something went wrong during run, see error below"
    Write-Host ""
    Write-Host $Error
}