#!/bin/bash

cp -f build-bom.gradle build.gradle
rm -f gradle.lockfile
./gradlew dependencies --write-locks
sed -i '' -e 's/3.3.2/3.3.+/g' build.gradle
./gradlew clean build