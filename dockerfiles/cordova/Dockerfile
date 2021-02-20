FROM gradle:jdk8-slim

USER root
RUN apt-get update && \
    apt-get install -y curl unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
USER gradle
WORKDIR /home/gradle
ENV PATH="/home/gradle/bin/cmdline-tools/tools/bin:${PATH}"
ENV ANDROID_SDK_ROOT="/home/gradle/bin"
# Install nvm, node, cordova, android-sdk-tools
# Install android build tools && remove android emulator
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash && \
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install node && \
    npm install -g cordova && \
    mkdir bin && cd bin && \
    curl -o linux.zip "$(curl -s 'https://developer.android.com/studio'|egrep -o 'https?://.*linux.*\.zip')" && \
    unzip linux.zip && \
    rm linux.zip && \
    # https://stackoverflow.com/questions/65262340/cmdline-tools-could-not-determine-sdk-root
    mv cmdline-tools tools && \
    mkdir cmdline-tools && \
    mv tools cmdline-tools && \
    yes|sdkmanager --licenses && \
    sdkmanager "$(sdkmanager --list|grep 'build-tools;'|tr -s ' '|cut -d' ' -f2|sort -n|tail -1)" && \
    sdkmanager --uninstall emulator
CMD bash