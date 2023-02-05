#!/bin/bash

ZIP_CMD=7z

if [ ! "command -v ${ZIP_CMD}" ]; then
    echo "No 7z command found in PATH. Either add it to your PATH or set the env var ZIP_CMD to the 7z binary file location."
    exit -1
fi

OUT_DIR=.package
OUT_DIR_SOURCE=${OUT_DIR}/source
OUT_DIR_RELEASE=${OUT_DIR}/release
OUT_DIR_OTHER=${OUT_DIR}/other
OUT_DIR_PRESS=${OUT_DIR}/press

TARGET_OUTPUT=lynx-of-the-stars.zip

SOURCE_FILES="project.godot Actors GameState GUI Levels Models Shaders Textures"
BUILD_FILES=.build/
PRESS_FILES=ScreenShots/
OTHER_FILES=README.md
LICENSE_FILE=LICENSE

rm -v ${TARGET_OUTPUT}
rm -vrf ${OUT_DIR}

mkdir -vp ${OUT_DIR}
mkdir -vp ${OUT_DIR_SOURCE}
mkdir -vp ${OUT_DIR_OTHER}

# license
cp -v ${LICENSE_FILE} ${OUT_DIR}/licence.txt

# other
cp -Rv ${OTHER_FILES} ${OUT_DIR_OTHER}

# source
cp -Rv ${SOURCE_FILES} ${OUT_DIR_SOURCE}

# release
cp -Rv ${BUILD_FILES} ${OUT_DIR_RELEASE}

# press
cp -Rv ${PRESS_FILES} ${OUT_DIR_PRESS}

# zip it all!
cd ${OUT_DIR} && ${ZIP_CMD} a -r -bb2 ../${TARGET_OUTPUT} .
