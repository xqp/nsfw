$SOURCE_DIR = Convert-Path .
$BUILD_DIR = "$SOURCE_DIR\build"
$INSTALL_DIR = "$SOURCE_DIR\install"
$INSTALL_PREFIX = "usr/local"

if (-not (Test-Path $SOURCE_DIR/ci)) {
    throw "must run inside repository root"
}

if (Test-Path $BUILD_DIR) {
    Remove-Item -Recurse -Force $BUILD_DIR
}

if (Test-Path $INSTALL_DIR) {
    Remove-Item -Recurse -Force $INSTALL_DIR
}

New-Item -ItemType directory -Path $BUILD_DIR
New-Item -ItemType directory -Path $INSTALL_DIR

Set-Location -Path $BUILD_DIR

cmake -G "Visual Studio 14 2015 Win64"                      `
      -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR\$INSTALL_PREFIX" `
      $SOURCE_DIR
	  
cmake --build . --target install

Set-Location -Path $SOURCE_DIR
