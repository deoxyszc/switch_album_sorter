$currentdir = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$inputdir = $currentdir + "\Album"
$outputdir = $currentdir + "\Album-sorted"
$CONF = (Get-Content "game-id.json") | ConvertFrom-Json
#Write-Host $currentdir

if (-not (Test-Path -Path $outputdir))
{
    New-Item -Path $currentdir -Name "Album-sorted" -type "directory"
}

$fileList = Get-ChildItem  $inputdir -recurse | ?{$_.PsIsContainer -eq $false -and $_.Name -match "\w.jpg$|\w.mp4$"} | %{$_.FullName}
Foreach ($file in $fileList)
{
    $filename_parse = (Get-Item $file).Basename -Split "-"
    $gamename = $CONF.($filename_parse[1])
    If($gamename -eq $null) 
    {
        $gamename = '其他'
    }
    $tempdir = $outputdir + '\' + $gamename
    $newdir  = $tempdir + '\' + (Split-Path -Leaf $file)
    if (-not (Test-Path -Path $tempdir))
    {
        New-Item -Path $outputdir -Name $gamename -type "directory"
    }
    #$filename = (Get-Item $file).Basename
    #Write-Host $gamename
    if (-not (Test-Path -Path $newdir))
    {
        Write-Host $file
        Write-Host $newdir
        Copy-Item $file $newdir
    }
}