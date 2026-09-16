#!/bin/bash

IMAGE_NAME="jiwooooo0/calculator"
TAG="latest"

# 1. 기존 컨테이너 중지 및 강제 삭제 (-f 옵션으로 실행 여부 상관없이 삭제)
if docker ps -a --format '{{.Names}}' | grep -Eq "^calculator$"; then
  echo "기존 calculator 컨테이너 삭제 중..."
  docker rm -f calculator || true
fi

# 2. 기존 이미지 삭제
if docker images --format '{{.Repository}}' | grep -Eq "^${IMAGE_NAME}$"; then
  echo "이미지 $IMAGE_NAME 삭제 중..."
  docker rmi -f "$IMAGE_NAME:$TAG" || true
fi

# 3. 새로운 이미지 다운로드
echo "이미지 $IMAGE_NAME:$TAG 다운로드 중..."
docker pull "$IMAGE_NAME:$TAG"

# 4. 컨테이너 실행
echo "새 컨테이너 실행 중..."
docker run -d -p 9000:9000 --name calculator "$IMAGE_NAME:$TAG"

# 5. 불필요한 댕글링 이미지 정리
docker image prune -f

echo "배포 완료!"