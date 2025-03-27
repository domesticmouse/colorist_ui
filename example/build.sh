#!/bin/bash

# Generate the freezed and json_serializable code
dart run build_runner build --delete-conflicting-outputs

# Format all Dart files
dart format lib

# Fix issues
dart fix --apply

# Analyze everything
dart analyze .
