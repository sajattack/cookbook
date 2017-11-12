VERSION=2.0.7
TAR=https://www.libsdl.org/release/SDL2-$VERSION.tar.gz

function recipe_version {
    echo "$VERSION"
    skip=1
}

function recipe_update {
    echo "skipping update"
    skip=1
}

function recipe_build {
    ./autogen.sh
    ./configure --prefix=/ --host=${HOST} --disable-shared --disable-pulseaudio --disable-jack --disable-video-x11  --disable-loadso --disable-threads --disable-timers --enable-audio --enable-dummyaudio --enable-video-orbital
    make 
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
