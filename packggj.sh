#!/bin/bash

OUT_DIR=.package
OUT_DIR_SOURCE=${OUT_DIR}/source
OUT_DIR_RELEASE=${OUT_DIR}/release
OUT_DIR_OTHER=${OUT_DIR}/other
OUT_DIR_PRESS=${OUT_DIR}/press

SOURCE_FILES="project.godot Actors GameState GUI Levels Models Shaders Textures"
BUILD_FILES=.build/
OTHER_FILES=.other/
PRESS_FILES=.press/
LICENSE_FILE=LICENSE

rm -rf ${OUT_DIR}
mkdir -p ${OUT_DIR}
mkdir -p ${OUT_DIR_SOURCE}

# license
cp ${LICENSE_FILE} ${OUT_DIR}/licence.txt

# source
cp -R ${SOURCE_FILES} ${OUT_DIR_SOURCE}

# release
cp -R ${BUILD_FILES} ${OUT_DIR_RELEASE}

# press
cp -R ${OTHER_FILES} ${OUT_DIR_OTHER}

# other
cp -R ${PRESS_FILES} ${OUT_DIR_PRESS}

# zip it all!
cd ${OUT_DIR} && tar -cvf ../lynx-of-the-stars.zip .
