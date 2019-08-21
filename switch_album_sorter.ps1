$currentdir = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$inputdir = $currentdir + "\Album"
$outputdir = $currentdir + "\Album-sorted"
$CONF = (Get-Content "game-id.json") | ConvertFrom-Json  -ErrorAction "SilentlyContinue"
If (!$?)
{
    Write-Host "json格式错误，无法读取";
    break
}

if (-not (Test-Path -Path $outputdir))
{
    New-Item -Path $currentdir -Name "Album-sorted" -type "directory"
}

$fileList = Get-ChildItem  $inputdir -recurse | ?{$_.PsIsContainer -eq $false -and $_.Name -match "\w.jpg$|\w.mp4$"} | %{$_.FullName}

Foreach ($file in $fileList)
{
    #通过截图文件名获取游戏ID，通过ID查找json，获取游戏名#
    $filename_parse = (Get-Item $file).Basename -Split "-"
    $gamename = $CONF.($filename_parse[1])
    
    #如果获取不到游戏名，需要打开对应截图，请求用户输入游戏名并记录#
    #查找json中的记录#
    If($gamename -eq $null) 
    {
        Invoke-Item $file
        $tempgamename = Read-Host '请输入现在打开的截图对应的游戏名：'
        $CONF | add-member -Name $filename_parse[1] -Value $tempgamename -MemberType NoteProperty
        $gamename = $tempgamename
        #Write-Host $CONF.($filename_parse[1])
    }
    $tempdir = $outputdir + '\' + $gamename
    $newdir  = $tempdir + '\' + (Split-Path -Leaf $file)
    if (-not (Test-Path -Path $tempdir))
    {
        New-Item -Path $outputdir -Name $gamename -type "directory"
    }
    if (-not (Test-Path -Path $newdir))
    {
        Write-Host $file
        Write-Host $newdir
        Copy-Item $file $newdir
    }
}
ConvertTo-Json $CONF | Out-File ($currentdir + "\game-id.json")
Write-Host "处理完成！"
