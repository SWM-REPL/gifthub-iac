#!/bin/bash

# 필요한 패키지 설치
sudo apt-get update
sudo apt-get install -y docker.io docker-compose

# 환경 변수 설정
export PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
export PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4 | sed 's/\.[0-9]*$/.2/')

# OpenVPN 서비스 시작
sudo -E docker-compose up -d