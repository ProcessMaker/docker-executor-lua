set -e
set -x

BRANCH=${BRANCH:=master}
TAG=${TAG:=dev-$BRANCH}
REPO=${REPO:=ProcessMaker/pm4-sdk-lua}
ROCKFILE=pmsdk-1.0.0-1.all.rock

curl -f -L -O https://github.com/${REPO}/raw/${BRANCH}/dist/${ROCKFILE}
docker build -t processmaker/pm4-docker-executor-lua:${TAG} --build-arg ROCKFILE=${ROCKFILE} .

# Push to dockerhub here
