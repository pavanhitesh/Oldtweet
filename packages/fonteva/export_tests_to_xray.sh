#!/bin/bash

BASE_URL=xray.cloud.getxray.app
PROJECT=PD

KEYS=$1

token=$(curl -H "Content-Type: application/json" -X POST --data @"packages/fonteva/xray_auth.json" $BASE_URL/api/v2/authenticate| tr -d '"')

cd packages/fonteva/e2e/features
  if [[ "$OSTYPE" == "msys"* ]]; then
    7z a -tzip -r features.zip $KEYS.feature
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    zip -r features.zip $KEYS.feature
  fi
cd -

curl \
-H "Content-Type: multipart/form-data" \
-H "Authorization: Bearer $token"  \
-F "file=@packages/fonteva/e2e/features/features.zip" \
-F "testInfo=@packages/fonteva/testInfo.json" \
"$BASE_URL/api/v2/import/feature?projectKey=$PROJECT"

rm -rf packages/fonteva/e2e/features/features.zip
