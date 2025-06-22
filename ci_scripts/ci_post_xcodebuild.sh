#!/bin/bash

# Exit on any error
set -e

# Navigate to the project directory
cd "$CI_PRIMARY_REPOSITORY_PATH" || { echo "ERROR: Failed to cd to $CI_PRIMARY_REPOSITORY_PATH"; exit 1; }

# Debug: Show current directory and contents
echo "CI_PRIMARY_REPOSITORY_PATH: $CI_PRIMARY_REPOSITORY_PATH"
echo "Current directory: $PWD"
ls -la

# Declare variables
SCHEME="DemoXcodeCloud"
PRODUCT_NAME="DemoXcodeCloud"
PROJECT_NAME="DemoXcodeCloud"

fastlane test
# sonar-scanner

# # Clean, build, and test project
# xcodebuild \
# -project "${PROJECT_NAME}.xcodeproj" \
# -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.3.1' \
# -scheme "${SCHEME}" \
# -derivedDataPath DerivedData/ \
# -enableCodeCoverage YES \
# -resultBundlePath DerivedData/Logs/Test/ResultBundle.xcresult \
# clean build test

# # Run slather
# echo "Start run slather"
# fastlane slather