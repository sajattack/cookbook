GIT=https://github.com/OpenRCT2/OpenRCT2
BUILD_DEPENDS=(zlib curl openssl jansson libzip libpng16 libiconv sdl2 speexdsp bzip2 libm)

export AR="${HOST}-ar"
export AS="${HOST}-as"
export CC="${HOST}-gcc"
export CXX="${HOST}-g++"
export LD="${HOST}-ld"
export NM="${HOST}-nm"
export OBJCOPY="${HOST}-objcopy"
export OBJDUMP="${HOST}-objdump"
export RANLIB="${HOST}-ranlib"
export READELF="${HOST}-readelf"
export STRIP="${HOST}-strip"

function recipe_version {
    skip=1
}

function recipe_update {
    echo "skipping update"
    skip=1
}

function recipe_build {
    mkdir -p build
    sysroot="${PWD}/../sysroot"
    export CMAKE_C_FLAGS="--sysroot=$sysroot -I$sysroot/include -L$sysroot/lib -Wno-error"
    export CMAKE_CXX_FLAGS="--sysroot=$sysroot -I$sysroot/include -L$sysroot/lib -Wno-error"
    export CMAKE_C_LINK_FLAGS="--sysroot=$sysroot -I$sysroot/include -L$sysroot/lib -Wno-error"
    export CMAKE_CXX_LINK_FLAGS="--sysroot=$sysroot -I$sysroot/include -L$sysroot/lib -Wno-error"
    export CMAKE_FIND_ROOT_PATH=$sysroot
    cd build
    cmake -DSTATIC=ON -DSDL2_INCLUDE_DIRS=$sysroot/include/SDL2 -DCMAKE_SYSROOT=${sysroot} -DDISABLE_TTF=ON -DDISABLE_NETWORK=ON -DDISABLE_HTTP_TWITCH=ON -DDISABLE_OPENGL=ON -I${sysroot}/include ../
    make VERBOSE=1
    skip=1
}

function recipe_test {
    echo "skipping test"
    skip=1
}

function recipe_clean {
    make clean
    skip=1
}

function recipe_stage {
    dest="$(realpath $1)"
    make DESTDIR="$dest" install
    skip=1
}
