#!/bin/bash

# Get current version with commit hash and date
VERSION=$(git describe --tags --dirty --always --long --abbrev=7)

# Update Cargo.toml with the new version
sed -i "s/^version = \".*\"$/version = \"$VERSION\"/" Cargo.toml
