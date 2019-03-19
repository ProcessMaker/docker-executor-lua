set -e
set -x

BRANCH=${BRANCH:=master}
TAG=${TAG:=dev-$BRANCH}
REPO=${REPO:=ProcessMaker/pm4-sdk-lua}

rm -rf sdk-repo
git clone --branch ${BRANCH} --depth 1 https://github.com/${REPO}.git ./sdk-repo
docker build -t processmaker/pm4-docker-executor-lua:${TAG} .

# Push to dockerhub here
