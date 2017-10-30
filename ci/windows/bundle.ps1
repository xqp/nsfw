# prepare bundle
if (Test-Path -Path usr) {
  Remove-Item -Path usr -Force -Recurse
}

# compress
Compress-Archive -Path install/usr -DestinationPath nsfw.zip
