set -e
set -x

BRANCH=${BRANCH:=master}
TAG=${TAG:=dev-${BRANCH//[\/]/-}}

pushd src
    if [[ ! -d "sdk-lua" ]]; then
        git clone --branch ${BRANCH} --depth 1 https://github.com/ProcessMaker/sdk-lua.git
    fi
popd

docker build -t processmaker4/executor-lua:${TAG} .
rm -rf src/sdk-lua
