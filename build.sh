set -e
set -x

BRANCH=${BRANCH:=master}
TAG=${TAG:=dev-${BRANCH//[\/]/-}}

pushd src
    if [[ ! -d "pm4-sdk-lua" ]]; then
        git clone --branch ${BRANCH} --depth 1 https://github.com/ProcessMaker/pm4-sdk-lua.git
    fi
popd

docker build -t processmaker/pm4-docker-executor-lua:${TAG} .
rm -rf src/pm4-sdk-lua

# Push to dockerhub here
