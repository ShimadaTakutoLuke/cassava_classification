FROM nvidia/cuda:12.5.0-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# 基本ライブラリのインストール
RUN apt-get update && \
    apt-get install -y \
    git wget curl vim build-essential \
    jq ffmpeg imagemagick tmux screen \
    parallel htop geeqie iputils-ping net-tools

# Pythonのビルドができるようにパッケージをインストール
RUN apt-get install -y \
    build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
    libffi-dev liblzma-dev

# python3.10のインストール
RUN wget https://www.python.org/ftp/python/3.12.4/Python-3.12.4.tgz && \
    tar xzf Python-3.12.4.tgz && \
    cd Python-3.12.4 && \
    ./configure && \
    make && \
    make install

WORKDIR /home

# pythonライブラリのインストール
COPY ./requirements.txt /home/
RUN pip3 install --no-cache-dir -U pip && \
    pip3 install --no-cache-dir -r requirements.txt