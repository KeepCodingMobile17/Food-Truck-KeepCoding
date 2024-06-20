#!/bin/sh

#  ci_pre_xcodebuild.sh
#  Food Truck

echo 'Change Beta App Icon'
APP_ICON_PATH="/Volumes/workspace/repository/FoodTruck/Assets.xcassets/AppIcon.appiconset"
echo $APP_ICON_PATH
rm -rf $APP_ICON_PATH
mv "/Volumes/workspace/repository/ci_scripts/AppIcon.appiconset" $APP_ICON_PATH
