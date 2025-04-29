#!/bin/bash

# Stop if anything fails
set -e

# Generate the freezed and json_serializable code
dart run build_runner build --delete-conflicting-outputs

# Format all Dart files
dart format lib test

# Fix issues
dart fix --apply

# Analyze everything
dart analyze .

# Run the tests with coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
echo "To view coverage run: open coverage/html/index.html"
