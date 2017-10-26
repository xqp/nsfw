# prepare bundle
if (Test-Path -Path usr) {
  Remove-Item -Path usr -Force -Recurse
}
New-Item -ItemType  Directory -Force -Path usr/local/lib
New-Item -ItemType  Directory -Force -Path usr/local/include
Copy-Item build/src/Release/* usr/local/lib/ -Force -Recurse
Copy-Item includes\ include\nsfw -recurse
Copy-Item include        usr/local/     -Force -Recurse

# compress
Compress-Archive -Path usr -DestinationPath nsfw.zip
