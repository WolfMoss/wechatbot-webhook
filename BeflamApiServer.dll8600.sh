#!/bin/bash


data=$(date "+%Y%m%d")
CURRENT_DIR=$(cd $(dirname $0); pwd)
doname="webhook3001" # 你要运行的实例名称
imgname="webhook3001" # 你要打包的镜像名称
dirname="webhook3001" # 你当前目录名称

docker stop ${doname} ; \
docker rm -f ${doname} ; \
cd ${CURRENT_DIR} && \
docker build -t ${imgname} . && \
docker run --name ${doname} -m 3800M -d \
-v ${CURRENT_DIR}:/${dirname} \
-v /etc/localtime:/etc/localtime \
-p 3001:3001 ${imgname} # 你要映射的端口