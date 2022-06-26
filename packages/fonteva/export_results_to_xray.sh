#!/bin/bash

BASE_URL=xray.cloud.getxray.app
REPORT=$1
token=$(curl -H "Content-Type: application/json" -X POST --data @"packages/fonteva/xray_auth.json" "$BASE_URL/api/v1/authenticate"| tr -d '"')
# need to work on this
curl -H "Content-Type: multipart/form-data" -X POST -H "Authorization: Bearer $token"  -F "info=@packages/fonteva/testExecution.json"  -F "results=@packages/fonteva/tmp/reports/$REPORT" "$BASE_URL/api/v2/import/execution/cucumber/multipart"
