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


# Clean, build, and test project
xcodebuild \
-project "${PROJECT_NAME}.xcodeproj" \
-destination 'platform=iOS Simulator,name=iPhone 16,OS=18.3.1' \
-scheme "${SCHEME}" \
-derivedDataPath DerivedData/ \
-enableCodeCoverage YES \
-resultBundlePath DerivedData/Logs/Test/ResultBundle.xcresult \
clean build test


# Find profdata and binary
PROFDATA=$(find DerivedData/Logs/Test -name "Coverage.profdata" | head -n 1)
BINARY="./DerivedData/Build/Products/Debug-iphonesimulator/${PRODUCT_NAME}.app/${PRODUCT_NAME}"

# Check if profdata file exists
if [[ -z "$PROFDATA" || ! -f "$PROFDATA" ]]; then
  echo "ERROR: Unable to find Coverage.profdata. Ensure tests are running and coverage is enabled."
  exit 1
fi

# Check if binary exists
if [[ ! -f "$BINARY" ]]; then
  echo "ERROR: Binary not found at $BINARY"
  exit 1
fi

# Debug: Inspect profdata and binary
echo "PROFDATA: $PROFDATA"
ls -lh "$PROFDATA"
echo "BINARY: $BINARY"
file "$BINARY"

# Generate coverage report
xcrun llvm-cov show -instr-profile="$PROFDATA" "$BINARY" > sonarqube-coverage.report

# Verify the report was generated
if [[ ! -s sonarqube-coverage.report ]]; then
  echo "ERROR: Coverage report is empty or was not generated."
  exit 1
fi

echo "Coverage report generated successfully: sonarqube-coverage.report"