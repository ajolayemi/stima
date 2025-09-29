#!/bin/bash
# Script to setup app, it basically runs the flutterfire commands
# for the different app environments/flavors

bash flutterfire-config.sh dev
bash flutterfire-config.sh stg
bash flutterfire-config.sh prod