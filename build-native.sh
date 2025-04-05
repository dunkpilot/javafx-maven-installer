#!/bin/bash
# Script to create a native installer
# Exit on any error
set -e

# Check if the app has been built already
if [ ! -d "target/app" ]; then
  echo "App runtime not found. Building it first..."
  ./build-app.sh
fi

echo "===== Creating Native Installer ====="

# Detect OS and create appropriate installer
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  echo "Creating macOS DMG installer..."
  mvn jpackage:jpackage -Djpackage.type=dmg \
    -Djpackage.mac-package-identifier=com.example.fuckapp \
    -Djpackage.mac-package-name=FuckApp
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  echo "Creating Linux DEB installer..."
  mvn jpackage:jpackage -Djpackage.type=deb
elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* || "$OSTYPE" == "win32"* ]]; then
  # Windows
  echo "Creating Windows EXE installer..."
  mvn jpackage:jpackage -Djpackage.type=exe \
    -Djpackage.win-shortcut=true \
    -Djpackage.win-menu=true
else
  # Unknown OS
  echo "Unknown OS. Creating default installer..."
  mvn jpackage:jpackage
fi

echo "===== Native Installer Created ====="
echo "Check the target/dist directory for your installer"