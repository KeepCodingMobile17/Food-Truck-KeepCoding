#!/bin/sh

#  ci_pre_xcodebuild.sh
#  Food Truck

echo "Setting Food Truck Beta App Icon"
APP_ICON_PATH=$CI_WORKSPACE/Shared/Assets.xcassets/AppIcon.appiconset

# Remove existing App Icon
rm -rf $APP_ICON_PATH

# Replace with Beta App Icon
mv "$CI_WORKSPACE/ci_scripts/AppIcon-Beta.appiconset" $APP_ICON_PATH
