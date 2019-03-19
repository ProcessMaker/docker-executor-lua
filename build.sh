set -e
set -x

BRANCH=${BRANCH:=master}
TAG=${TAG:=dev-$BRANCH}

if [[ ! -d "lua-sdk" ]]; then
    git clone --branch ${BRANCH} --depth 1 https://github.com/ProcessMaker/pm4-sdk-lua.git ./lua-sdk
fi
docker build -t processmaker/pm4-docker-executor-lua:${TAG} .
rm -rf lua-sdk

# Push to dockerhub here
