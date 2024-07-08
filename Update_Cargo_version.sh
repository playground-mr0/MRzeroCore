#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if cargo-edit is installed
if ! command -v cargo-set-version &> /dev/null; then
    echo "cargo-edit not found. Installing..."
    cargo install cargo-edit
fi

# Ensure the PATH includes Cargo bin directory
export PATH="$HOME/.cargo/bin:$PATH"

# Get the current version from Cargo.toml
CURRENT_VERSION=$(grep '^version =' Cargo.toml | sed 's/version = "//;s/"//')

# Get the short commit hash
SHORT_HASH=$(git rev-parse --short HEAD)

# Combine to create a semver-compliant pre-release version string
VERSION="${CURRENT_VERSION}-${SHORT_HASH}"

# Print the version
echo "Current version: $VERSION"

# Print Cargo.toml before modification
echo "Cargo.toml before modification:"
cat Cargo.toml

# Update Cargo.toml with the new version
cargo set-version "$VERSION" || { echo "Failed to set version"; exit 1; }

# Print Cargo.toml after modification
echo "Cargo.toml after modification:"
cat Cargo.toml

# Optionally, update Cargo.lock (if needed)
cargo update -p PlaygroundMR01 --precise "$VERSION"

# Print Cargo.lock after modification
echo "Cargo.lock after modification:"
cat Cargo.lock
