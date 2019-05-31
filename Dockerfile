FROM ubuntu:16.04

ENV ANDROID_HOME="/var/opt/android"
ENV SDK_TOOLS "3859397"
ENV PATH="/var/opt/flutter/bin:/var/opt/android/tools:/var/opt/android/tools/bin:/var/opt/android/platform-tools:/var/opt/android/platform-tools/bin:${PATH}"

RUN add-apt-repository ppa:openjdk-r/ppa -y
RUN apt-get update
RUN apt-get install -y curl git unzip openjdk-8-jdk

WORKDIR /var/opt

RUN curl -o sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-${SDK_TOOLS}.zip
RUN unzip sdk-tools.zip -d android
RUN rm sdk-tools.zip

RUN sdkmanager --update
RUN yes | sdkmanager "build-tools;28.0.3"
RUN yes | sdkmanager "platforms;android-28"
RUN sdkmanager "tools"


RUN curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.5.4-hotfix.2-stable.tar.xz
RUN tar xf flutter.tar.xz
RUN rm flutter.tar.xz


RUN flutter upgrade

WORKDIR /root
