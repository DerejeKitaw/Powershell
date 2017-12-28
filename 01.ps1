 Write-Host -ForegroundColor Yellow "-------------------------------"
Write-Host -ForegroundColor Yellow "|Variables store your stuff   |"
Write-Host -ForegroundColor Yellow "-------------------------------"
Write-Host ""
# In power shell double qote will turn special feature to calculate 
## Inside a double qote if you need turn off  or escape some calculation use ` 
Write-Host -ForegroundColor green "-----------------------------"
Write-Host -ForegroundColor green 'Assigning a variable $MyVar=2 ' # single qote do not evaluate $MyVar
Write-Host -ForegroundColor green 'Assigning a variable ${My Var}="Hello" '
Write-Host ""
$MyVar=2
${My Var}="Hello"

#Output a variable
Write-Output $MyVar
Write-Host -ForegroundColor green "-----------------------------"
Write-Host -ForegroundColor green "|        Output             |"
Write-Host -ForegroundColor green "-----------------------------"
Write-Host ""
$MyVar
${My Var} # If there is space between variables need to use ${}

#Strongly type a variable
[String]$MyName="Jason"
[int]$Oops="Jason" # this will through error because string is casted to integer
[string]$ComputerName=Read-host "Enter Computer Name"
Write-Host -ForegroundColor green "Your computer name is $ComputerName "
Write-Host -ForegroundColor green "-----------------------------"

$p = Get-Process lsass
"process id=$p.id"
"process id=$($p.id)"
"Proccess id = $(read-host -Prompt "What should I give them?")" 
