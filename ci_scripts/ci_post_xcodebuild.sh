cd $CI_WORKSPACE

# declare variables
SCHEME=DemoXcodeCloud
PRODUCT_NAME=DemoXcodeCloud
PROJECT_NAME=DemoXcodeCloud
WORKSPACE_NAME=${PRODUCT_NAME}.xcworkspace
APP_VERSION=$(sed -n '/MARKETING_VERSION/{s/MARKETING_VERSION = //;s/;//;s/^[[:space:]]*//;p;q;}' ./${PRODUCT_NAME}.xcodeproj/project.pbxproj)

# clean, build and test project
xcodebuild \
-project ${PROJECT_NAME}.xcodeproj \
-destination 'platform=iOS Simulator,name=iPad (10th generation),OS=latest' \
-scheme ${SCHEME} \
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