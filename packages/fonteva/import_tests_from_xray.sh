#!/bin/bash

BASE_URL=xray.cloud.getxray.app
PROJECT=PD

KEYS=$1

token=$(curl -H "Content-Type: application/json" -X POST --data @"packages/fonteva/xray_auth.json" $BASE_URL/api/v2/authenticate| tr -d '"')

rm -rf packages/fonteva/e2e/features/$KEYS.zip

curl \
-H "Content-Type: application/json" \
-X GET \
-H "Authorization: Bearer $token" \
"$BASE_URL/api/v1/export/cucumber?keys=$KEYS" \
-o packages/fonteva/e2e/features/$KEYS.zip


# rm -rf packages/fonteva/e2e/xray/$KEYS.feature
unzip -o packages/fonteva/e2e/features/$KEYS.zip -d packages/fonteva/e2e/features/$KEYS
mv packages/fonteva/e2e/features/$KEYS/*.feature packages/fonteva/e2e/features/$KEYS.feature
rm -rf packages/fonteva/e2e/features/$KEYS.zip
rm -rf packages/fonteva/e2e/features/$KEYS
