#!/bin/bash
# Script to generate Firebase configuration files for different environments/flavors
# Feel free to reuse and adapt this script for your own projects

if [[ $# -eq 0 ]]; then
  echo "Error: No environment specified. Use 'dev', 'stg', or 'prod'."
  exit 1
fi

case $1 in
  dev)
    flutterfire config \
      --project=stime-dev-654b7 \
      --out=lib/firebase_options_dev.dart \
      --android-package-name=com.incampagna.stima.dev \
      --android-out=android/app/src/dev/google-services.json \
      --ios-bundle-id=com.incampagna.stima.dev \
      --ios-out=ios/config/dev/GoogleService-Info.plist
    ;;
  stg)
    flutterfire config \
      --project=stime-stg \
      --out=lib/firebase_options_stg.dart \
      --android-package-name=com.incampagna.stima.stg \
      --android-out=android/app/src/stg/google-services.json \
      --ios-bundle-id=com.incampagna.stima.stg \
      --ios-out=ios/config/stg/GoogleService-Info.plist
    ;;
  prod)
    flutterfire config \
      --project=stime-99f87 \
      --out=lib/firebase_options_prod.dart \
      --android-package-name=com.incampagna.stima \
      --android-out=android/app/src/prod/google-services.json \
      --ios-bundle-id=com.incampagna.stima \
      --ios-out=ios/config/prod/GoogleService-Info.plist
    ;;
  *)
    echo "Error: Invalid environment specified. Use 'dev', 'stg', or 'prod'."
    exit 1
    ;;
esac