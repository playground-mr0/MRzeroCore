#!/bin/bash

# Check if cargo-edit is installed
if ! command -v cargo-set-version &> /dev/null; then
    echo "cargo-edit not found. Installing..."
    cargo install cargo-edit
fi

# Ensure the PATH includes Cargo bin directory
export PATH="$HOME/.cargo/bin:$PATH"

# Get current version including commit hash and dirty flag
VERSION=$(git describe --tags --dirty --always --long --abbrev=7)

echo "Current version: $VERSION"

# Update Cargo.toml with the new version
#cargo edit --set-version "$VERSION"
cargo set-version --version "$VERSION"

# Optionally, update Cargo.lock (if needed)
cargo update -p PlaygroundMR01 --precise "$VERSION"

# Any other commands related to your build process
