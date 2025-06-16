#!/bin/sh
set -e

if [ "$CI_ACTION" = "test" ]; then

    if ! command -v slather &> /dev/null; then
        echo "duydl>> Install slather"
        bundle install
        # brew install slather
    fi
    
    slather coverage --sonarqube-xml

    # mkdir -p $CI_DERIVED_DATA_PATH/artifacts
    # cp -r ./coverage-report $CI_DERIVED_DATA_PATH/artifacts/

    echo "duydl>> Congrat generate report success!"
else
    echo "duydl>> Ignore slather, not TEST"
fi

exit 0