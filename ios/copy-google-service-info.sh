#!/bin/sh

# Usage: ./copy-google-service-info.sh dev|prod|staging

FLAVOR=$1

echo "Copying GoogleService-Info.plist for flavor: $FLAVOR"

PLIST_SOURCE="config/$FLAVOR/GoogleService-Info.plist"
PLIST_DEST="Runner/GoogleService-Info.plist"

if [ -f "$PLIST_SOURCE" ]; then
  cp "$PLIST_SOURCE" "$PLIST_DEST"
  echo "Copied $PLIST_SOURCE -> $PLIST_DEST"
else
  echo "ERROR: file not found $PLIST_SOURCE"
  exit 1
fi
