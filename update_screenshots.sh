#!/bin/bash

# Script to update app screenshots using Flutter Golden tests.
# This script runs the screenshots_test.dart and copies the results to assets/screenshots/

# Exit on error
set -e

# Change to the app directory
cd app

# Run the golden tests to update screenshots
echo "🚀 Generating screenshots from Flutter tests..."
flutter test test/screenshots_test.dart --update-goldens

# Go back to root
cd ..

# Copy the generated goldens to the assets folder
echo "📸 Copying screenshots to assets/screenshots/..."
mkdir -p assets/screenshots
cp app/test/goldens/home_screen.png assets/screenshots/home.png
cp app/test/goldens/profile_screen.png assets/screenshots/profile.png
cp app/test/goldens/counter_screen.png assets/screenshots/counter.png

echo "✅ Screenshots updated successfully!"
