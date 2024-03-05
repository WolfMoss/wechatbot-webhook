# 使用 Node.js 18 作为基础镜像
FROM node:18-alpine

# 创建工作目录
WORKDIR /app

# 非依赖变更缓存改层
COPY package.json pnpm-lock.yaml .npmrc ./

# 创建 patches 目录并复制所有内容
COPY patches ./patches

# 安装应用程序依赖项
RUN npm config set registry http://registry.npm.taobao.org/ && npm install -g pnpm && pnpm install --production && pnpm store prune && npm uninstall pnpm -g

# 复制应用程序代码到工作目录
COPY . .

# 如果收消息想接入webhook
ENV RECVD_MSG_API=http://10.10.10.5:8081/receive_msg
# 默认登录API接口访问token
ENV LOGIN_API_TOKEN=axiba
# 是否禁用默认登录
ENV DISABLE_AUTO_LOGIN=

# 暴露端口（你的 Express 应用程序监听的端口）
EXPOSE 3001

# 启动应用程序
CMD ["npm", "start"]