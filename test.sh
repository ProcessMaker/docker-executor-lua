set -e
set -x

API_TOKEN=bearer-token-here
API_HOST=http://bpm4.local.processmaker.com/api/1.0

EXECUTOR_IMAGE="processmaker/pm4-docker-executor-lua:dev-master"
EXECUTOR_DIR=${PWD}/tests/sdk

docker run --rm \
-v $EXECUTOR_DIR/data.json:/opt/executor/data.json \
-v $EXECUTOR_DIR/config.json:/opt/executor/config.json \
-v $EXECUTOR_DIR/script.lua:/opt/executor/script.lua \
-v $EXECUTOR_DIR/output.json:/opt/executor/output.json \
-e "API_TOKEN=$API_TOKEN" \
-e "API_HOST=$API_HOST" \
$EXECUTOR_IMAGE lua5.3 /opt/executor/bootstrap.lua

cat $EXECUTOR_DIR/output.json
echo '' > $EXECUTOR_DIR/output.json