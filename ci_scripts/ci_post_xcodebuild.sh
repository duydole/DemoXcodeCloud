#!/bin/sh
set -e

echo "duydl>> Danh sách file trong thư mục hiện tại:"
ls -la
echo "CI_WORKSPACE: $CI_WORKSPACE"
echo "CI_DERIVED_DATA_PATH: $CI_DERIVED_DATA_PATH"

cd $CI_PRIMARY_REPOSITORY_PATH

xcodebuild test \
-project DemoXcodeCloud.xcodeproj \
-scheme DemoXcodeCloud \
-destination 'platform=iOS Simulator,OS=18.3.1,name=iPhone 16' \
-enableCodeCoverage YES

if ! command -v slather &> /dev/null; then
    echo "duydl>> Install slather"
    # bundle install
    brew install slather
fi

slather coverage --sonarqube-xml

# mkdir -p $CI_DERIVED_DATA_PATH/artifacts
# cp -r ./coverage-report $CI_DERIVED_DATA_PATH/artifacts/

echo "duydl>> Congrat generate report success!"

exit 0