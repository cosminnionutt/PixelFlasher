#!/usr/bin/env bash
rm -rf build dist
VERSION=6.8.3.0
NAME="PixelFlasher"
DIST_NAME="PixelFlasher"

pushd "$(dirname "$0")"

if [[ $OSTYPE == 'darwin'* ]]; then
    echo "Building for MacOS"
    specfile=build-on-mac.spec
else
    echo "Building for Linux"
    specfile=build-on-linux.spec
fi

pyinstaller --log-level=DEBUG \
            --noconfirm \
            $specfile

if [[ $OSTYPE == 'darwin'* ]]; then
    # https://github.com/sindresorhus/create-dmg
    ls -l ./ dist/
    chmod +x dist/$NAME.app/Contents/MacOS/$NAME
    create-dmg "dist/$NAME.app"
    mv "$NAME $VERSION.dmg" "dist/$DIST_NAME.dmg"
fi

popd
ls -l build/ dist/

