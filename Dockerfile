FROM jenkins/jenkins:2.204.5-alpine
#自定义jenkins镜像
# 作者信息
MAINTAINER war kubernete jenkins "admin@lagou.com"
# 修改源
USER root
RUN echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" >> /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/latest-stable/community/" >> /etc/apk/repositories
# 安装需要的软件，解决时区问题
RUN apk --update add curl bash tzdata && \
    rm -rf /var/cache/apk/*
#修改镜像为东八区时间
ENV TZ Asia/Shanghai
ENV JENKINS_UC https://updates.jenkins-zh.cn
ENV JENKINS_UC_DOWNLOAD https://mirrors.tuna.tsinghua.edu.cn/jenkins

ENV JENKINS_OPTS="-Dhudson.model.UpdateCenter.updateCenterUrl=https://updates.jenkins-zh.cn/update-center.json"
ENV JENKINS_OPTS="-Djenkins.install.runSetupWizard=false"

COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/init.groovy
COPY hudson.model.UpdateCenter.xml /usr/share/jenkins/ref/hudson.model.UpdateCenter.xml
COPY mirror-adapter.crt /usr/share/jenkins/ref/mirror-adapter.crt
