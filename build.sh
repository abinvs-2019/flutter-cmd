#!/bin/bash

# Read the current version from pubspec.yaml
current_version=$(grep -o 'version: [0-9.]*' pubspec.yaml | cut -d' ' -f2)

# Increment the version number
new_version=$(echo $current_version | awk -F. -v OFS=. '{++$NF; print}')

# Replace the version number in pubspec.yaml using awk
awk -v current_version="$current_version" -v new_version="$new_version" '/version: / {sub(current_version, new_version)} 1' pubspec.yaml > temp.yaml && mv temp.yaml pubspec.yaml

# Build the APK
# flutter build apk

if [[ "\$1" == "-r" ]]; then
  # Build the app bundle in release mode
  flutter build apk
  flutter build appbundle --release
else
  # Build the APK
  flutter build apk
fi


# Print the new version and build numbers
echo "New version: $new_version"
echo "New build: $new_build"
