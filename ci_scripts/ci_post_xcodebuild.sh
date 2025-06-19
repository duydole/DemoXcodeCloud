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

# # Extract app version using agvtool
# APP_VERSION=$(agvtool what-marketing-version -terse1 || { echo "ERROR: Failed to retrieve APP_VERSION"; exit 1; })

# # Verify APP_VERSION
# if [[ -z "$APP_VERSION" ]]; then
#   echo "ERROR: APP_VERSION is empty"
#   exit 1
# fi
# echo "App Version: $APP_VERSION"

# Clean, build, and test project
xcodebuild \
-project "${PROJECT_NAME}.xcodeproj" \
-destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=latest' \
-scheme "${SCHEME}" \
-derivedDataPath DerivedData/ \
-enableCodeCoverage YES \
-resultBundlePath DerivedData/Logs/Test/ResultBundle.xcresult \
clean build test


# # find profdata and binary
# PROFDATA=$(find . -name "Coverage.profdata")
# BINARY=$(find . -path "*${PRODUCT_NAME}.app/${PRODUCT_NAME}")

# # check if we have profdata file
# if [[ -z $PROFDATA ]]; then
# echo "ERROR: Unable to find Coverage.profdata. Be sure to execute tests before running this script."
# exit 1
# fi

# # extract coverage data from project using xcode native tool
# xcrun --run llvm-cov show -instr-profile=${PROFDATA} ${BINARY} > sonarqube-coverage.report

# # run sonar scanner and upload coverage data with the current app version
# sonar-scanner \
# -Dsonar.projectVersion=${APP_VERSION}