#!/bin/bash

MODEL_DIR="<PATH_TO_PROJECT>/ieam-edge-mvi-demo/fire-ext"
. ../env.sh

APP_IMAGE_BASE=""
IMAGE_VERSION=""
APP_IMAGE=$APP_IMAGE_BASE:$IMAGE_VERSION
OPERATOR_IMAGE_BASE=""
OPERATOR_IMAGE=$OPERATOR_IMAGE_BASE:$IMAGE_VERSION

cd config/manager && kustomize edit set image controller="$OPERATOR_IMAGE" && cd ../..
sed -i -e "s|{{APP_IMAGE_BASE}}|$APP_IMAGE_BASE|" config/samples/demo.yaml
sed -i -e "s|{{IMAGE_VERSION}}|$IMAGE_VERSION|" config/samples/demo.yaml

# Update Version in horizon/hzn.json if you make ANY change
mv horizon/hzn.json /tmp/hzn.json
jq --arg IMAGE_VERSION "1.0.0" '.MetadataVars.SERVICE_VERSION |= $IMAGE_VERSION' /tmp/hzn.json > horizon/hzn.json

make docker-build docker-push IMG=$OPERATOR_IMAGE

rm operator.tar.gz
kustomize build config/default > deploy/kustomize_manifests_operator.yaml
tar -C deploy -czf operator.tar.gz .

hzn exchange service publish -f $MODEL_DIR/horizon/service.definition.json --overwrite
HZN_POLICY_NAME="<IEAM_ORG>/policy-mvi-fire-ext-model"
hzn exchange deployment removepolicy -f $HZN_POLICY_NAME
sleep 10
hzn exchange deployment addpolicy -f $MODEL_DIR/horizon/service.policy.json $HZN_POLICY_NAME
# hzn exchange deployment updatepolicy -f $MODEL_DIR/horizon/service.policy.json $HZN_POLICY_NAME
