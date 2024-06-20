#!/bin/sh

#  ci_pre_xcodebuild.sh
#  Food Truck

echo 'Change Beta App Icon'
APP_ICON_PATH="$CI_PRIMARY_REPOSITORY_PATH/FoodTruck/Assets.xcassets/AppIcon.appiconset"
rm -rf $APP_ICON_PATH
mv "$CI_PRIMARY_REPOSITORY_PATH/ci_scripts/AppIcon-Beta.appiconset" $APP_ICON_PATH
