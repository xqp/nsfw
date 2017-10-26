. ${PSScriptRoot}\common.ps1

Initialize-VisualStudio

mkdir build
cd build

cmake -G"Visual Studio 14 2015 Win64" ..

msbuild nsfw.sln  /t:Rebuild `
                  /p:Configuration=Release
if ($LastExitCode -ne 0) {
    exit 1
}

msbuild nsfw.sln /t:Rebuild  `
                 /p:Configuration=Debug
if ($LastExitCode -ne 0) {
    exit 1
}

cd ..

exit 0
