# BASE 생성
FROM ubuntu:20.04 AS HT-PROCESS-BASE
# APT 서버를 카카오서버로 변경 / 새로운 패키지 버전 확인 및 업그레이드
RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list \
 && sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list \
 && apt-get update --fix-missing \
 && apt-get upgrade -y \
 # JDK(headless) 설치
 && apt-get install --no-install-recommends -y openjdk-8-jdk-headless \
 # 로케일, 타임존 관련 패키지 설치
 && apt-get install --no-install-recommends -y locales language-pack-ko tzdata \
 # 기타 디버깅시 유용한 패키지들 설치
 && apt-get install --no-install-recommends -y git iputils-ping dnsutils traceroute wget curl telnet tree vim
# 타임존 설정
ENV TZ Asia/Seoul
RUN rm -rf /etc/localtime; ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime
# 로케일 설정
RUN locale-gen ko_KR.UTF-8
ENV LANG ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8

WORKDIR /root/workspace
RUN git clone https://github.com/myungyun/springboot-demo.git
