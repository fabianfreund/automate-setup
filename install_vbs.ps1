$url = "https://dl.vive.com/vbspc"
$outpath = "C:/temp/vbs.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath

$args = @('/s', '/v', '/qn')
Start-Process -Filepath "C:/temp/vbs.exe" -ArgumentList $args -PassThru