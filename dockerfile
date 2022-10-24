FROM ubuntu:20.04

RUN apt-get update \
    && apt-get install cifs-utils -y \
    && apt-get install rsync -y \
    && mkdir /mnt/smb 
