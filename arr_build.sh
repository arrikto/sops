#!/bin/bash
set -e
VERSION=$(git describe) 
VERSION="${VERSION:1}" # change example v3.7.1 to 3.7.1
go build -o sops -ldflags="-X go.mozilla.org/sops/v3/version.Version=$VERSION" ./cmd/sops 

echo "Successfully built with version: $(./sops --version)"

BUCKET=arrikto
OBJECT=sops/sops-${VERSION}
GSURL=gs://${BUCKET}/${OBJECT}
URL=https://storage.googleapis.com/${BUCKET}/${OBJECT}

echo To upload to GCS run:
echo "  gsutil cp ./sops ${GSURL}"

echo To make it public run:
echo "  gsutil acl ch -u AllUsers:R ${GSURL}"

echo To verify that it is publicly accessible run:
echo "  curl -I ${URL}"

