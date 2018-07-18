FROM openjdk:8-slim

RUN apt-get update -y && \
    apt-get install -y autoconf2.13 ccache gcc g++ git lib32gcc1 lib32ncurses5 lib32z1 make python wget zip zlib1g-dev && \
    apt-get clean

ENV BUILD_TOOLS_VERSION="23.0.3"
ENV ANDROID_HOME="/opt/android-sdk-linux"
ENV SDK_BASE="$ANDROID_HOME" \
    PATH="${PATH}:${GRADLE_HOME}/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin" \
    ORFOX_REPO_NAME="Orfox-setup"

RUN cd /opt && \
    wget -q https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
    tar --no-same-owner -xzf android-sdk_r*-linux.tgz && \
    rm -f android-sdk_r*-linux.tgz && \
    chown -R root:root $ANDROID_HOME

RUN cd $ANDROID_HOME/tools && \
    (echo y | ./android update sdk -a --no-ui --filter build-tools-$BUILD_TOOLS_VERSION,platform-tools,android-23,extra-android-m2repository,extra-google-m2repository)

RUN cd ~/ && \
    git clone https://github.com/Unpublished/$ORFOX_REPO_NAME && cd $ORFOX_REPO_NAME && git submodule update --init --recursive
RUN find / \( -uid +65535 \) -ls 2>/dev/null || true