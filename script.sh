IMAGE_NAME="jiwooooo0/calculator"
TAG="latest"

# 실행 중인 기존 컨테이너 중지 및 삭제
if docker ps -a | grep -q "calculator"; then
  echo "기존 calculator 컨테이너 중지 및 삭제..."
  docker stop calculator || true
  docker rm calculator || true
fi

# 기존 이미지 정리
if docker images | grep -q "$IMAGE_NAME"; then
  echo "기존 이미지 $IMAGE_NAME 삭제..."
  docker rmi -f "$IMAGE_NAME:$TAG" || true
fi

# 새 이미지 다운로드
echo "새 이미지 다운로드 중..."
docker pull "$IMAGE_NAME:$TAG"

# 컨테이너 실행 (외부 포트 9000, 컨테이너 내부 포트 8080)
docker run -d -p 9000:8080 --name calculator "$IMAGE_NAME:$TAG"

# 미사용 댕글링 이미지 정리
docker image prune -f

echo "배포 완료!"