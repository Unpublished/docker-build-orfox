FROM unpublished/build-orfox:full_base

ENV NDK_REVISION="15c"
ENV ANDROID_NDK_HOME="/opt/android-ndk-r$NDK_REVISION"
ENV NDK_BASE=$ANDROID_NDK_HOME

RUN cd /opt && \
    wget -q https://dl.google.com/android/repository/android-ndk-r$NDK_REVISION-linux-x86_64.zip && \
    unzip -q android-ndk-r$NDK_REVISION-linux-x86_64.zip && \
    rm android-ndk-r$NDK_REVISION-linux-x86_64.zip