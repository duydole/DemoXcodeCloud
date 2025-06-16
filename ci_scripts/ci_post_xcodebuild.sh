#!/bin/sh
set -e

echo "duydl>> start cd project"
cd $CI_PROJECT_FILE_PATH
echo "duydl>> end cd project"

xcodebuild test \
-project DemoXcodeCloud.xcodeproj \
-scheme DemoXcodeCloud \
-destination 'platform=iOS Simulator,OS=18.2,name=iPhone 15 Pro' \
-enableCodeCoverage YES

if ! command -v slather &> /dev/null; then
    echo "duydl>> Install slather"
    bundle install
    # brew install slather
fi

slather coverage --sonarqube-xml

# mkdir -p $CI_DERIVED_DATA_PATH/artifacts
# cp -r ./coverage-report $CI_DERIVED_DATA_PATH/artifacts/

echo "duydl>> Congrat generate report success!"

exit 0