#!/bin/bash

# OpenVPN 설정 파일 이름 설정
OVPN_FILE="client.ovpn"

# Docker 컨테이너에서 OpenVPN 설정 추출
OVPN_CONFIG=$(sudo docker exec -i openvpn show-client-config)

# 추출된 설정을 파일로 저장
echo "$OVPN_CONFIG" > "$OVPN_FILE"

# 파일 생성 확인
if [ -f "$OVPN_FILE" ]; then
    echo "OpenVPN 설정 파일이 성공적으로 생성되었습니다: $OVPN_FILE"
    echo "파일 내용:"
    cat "$OVPN_FILE"
else
    echo "OpenVPN 설정 파일 생성에 실패했습니다."
fi