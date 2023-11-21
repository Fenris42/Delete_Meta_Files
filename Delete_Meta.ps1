#Searches for and deletes Unity .meta extension files in current directory and its sub directories

try{

#get current directory
$path = Get-Location

#Search for Files ///////////////////////////////////////////////////////////////////////////////////////////////////////

#initialize variables
$answer = ""
$loopCheck = $false
$fileCount = 0

do{
    
    #promp user for input
    Write-Host ""
    Write-Host "Search for .meta files in $path ?"
    $answer = Read-Host "[Y/N]"

    #verify if valid answer
    $answer = $answer.ToLower()

    if($answer -eq "y" -or $answer -eq "n"){
        
        #input valid, exit loop
        $loopCheck = $true
        
    }
    else{
        
        #input invalid. error and reprompt user
        Write-Host ""
        Write-Host "[Error]: " -ForegroundColor Red -NoNewLine; Write-Host "Invalid Entry. Only [Y/N] Accepted"
    }
}
while($loopCheck -eq $false)




#user accepted search
if($answer -eq "y"){
    
    #console output
    Write-Host ""
    Write-Host "Searching for files:"
    Write-Host ""

    #get all files in current directory and sub directories
    $files = Get-ChildItem -Path $path -Name -Recurse
    

    #loop through files
    foreach($file in $files){
        
        #filter files for .meta files only
        if($File.EndsWith(".meta")){
            
            #console output found files
            Write-Output "$path\$file"
            $fileCount += 1
        }
    }

    #console output
    Write-Host ""
    Write-Host "$fileCount Files Found"
}
#user did not accept, exit
else{
    
    #console output
    Write-Host ""
    Write-Host "Aborted" -ForegroundColor Red
}



#Delete Files ///////////////////////////////////////////////////////////////////////////////////////////////////////

#reset variables
$answer = ""
$loopCheck = $false
$fileCount = 0

do{
    
    #prompt user for input
    Write-Host ""
    Write-Host "Delete all .meta files found?"
    $answer = Read-Host "[Y/N]"

    #verify valid answer
    $answer = $answer.ToLower()

    if($answer -eq "y" -or $answer -eq "n"){
        
        #input valid. exit loop
        $loopCheck = $true
        
    }
    else{

        #input invalid. error and reprompt user
        Write-Host ""
        Write-Host "[Error]: " -ForegroundColor Red -NoNewLine; Write-Host "Invalid Entry. Only [Y/N] Accepted"
    }
}
while($loopCheck -eq $false)



#user accepted delete
if($answer -eq "y"){
    
    #console output
    Write-Host ""
    Write-Host "Searching for files:"
    Write-Host ""

    #get all files in current directory and sub directories
    $files = Get-ChildItem -Path $path -Name -Recurse
    
    #loop through files
    foreach($file in $files){
        
        #filter files for .meta files only
        if($File.EndsWith(".meta")){
            
            #console ouptut deleted file
            Write-Output "[Deleted]: $path\$file"
            $fileCount += 1
            
            #delete file
            Remove-Item -LiteralPath "$path\$file"
        }
    }

    #console output
    Write-Host ""
    Write-Host "$fileCount Files Deleted"
}
#user did not accept, exit
else{
    
    #console output
    Write-Host ""
    Write-Host "Aborted" -ForegroundColor Red
}



#Error Handling ///////////////////////////////////////////////////////////////////////////////////////////////////////
}catch{
    
    #something errored out during run. display error and exit
    Write-Host ""
    Write-Host "[Error]: " -ForegroundColor Red -NoNewLine; Write-Host "Something went wrong during run, see error below"
    Write-Host ""
    Write-Host $Error
}