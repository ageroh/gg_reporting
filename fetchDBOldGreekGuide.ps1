
$dirExist = Test-Path C:\tempBackups\

If($dirExist -eq $True) {
   Remove-Item C:\tempBackups\ -Force -Recurse
   New-Item -ItemType directory -Path C:\tempBackups\
}



$client = New-Object system.net.webclient;
$client.Credentials = New-Object  System.Net.NetworkCredential("arg", "Hjf##42w");


$nowDate = Get-Date
$OneMonthAgo = $nowDate.AddDays(-30)
$TwoMonthAgo = $nowDate.AddDays(-60)

$strM1 = Get-Date $OneMonthAgo -UFormat %Y-%m-%d
$strM2 = Get-Date $TwoMonthAgo -UFormat %Y-%m-%d

Write-Host "Fetching: http://backup.qwe.gr/primemedia/databases/newsgr-sql/"$strM1"/ContentDB_165.BAK"
$client.DownloadFile("http://backup.qwe.gr/primemedia/databases/newsgr-sql/"+$strM1+"/ContentDB_165.BAK", "C:\tempBackups\ContentDB_165_One_Month_Ago.bak");
Write-Host "Done."

Write-Host "Fetching: http://backup.qwe.gr/primemedia/databases/newsgr-sql/"$strM2"/ContentDB_165.BAK"
$client.DownloadFile("http://backup.qwe.gr/primemedia/databases/newsgr-sql/"+$strM2+"/ContentDB_165.BAK", "C:\tempBackups\ContentDB_165_Two_Months_Ago.bak");
Write-Host "Done."

$fileChk = "C:\tempBackups\ContentDB_165_One_Month_Ago.bak"
$fileChk2 = "C:\tempBackups\ContentDB_165_Two_Months_Ago.bak"
if (Test-Path $fileChk) { 
  if((Get-Item $fileChk).length -gt 10mb){
    if (Test-Path $fileChk2) { 
	  if((Get-Item $fileChk2).length -gt 10mb){
        Add-PSSnapin sqlservercmdletsnapin100
		Add-PSSnapin SqlServerProviderSnapin100
		Invoke-Sqlcmd -InputFile "C:\AdminScripts\restore_GG_DB_refresh_Functions.sql" -ServerInstance "localhost"
	    Write-Host "Succefully completed!"
     }
   }
  }
}
else{
	Write-Host "Error Occured!";
	# sent mail !!!! !!!! !!!
}