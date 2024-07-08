#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if cargo-edit is installed
if ! command -v cargo-edit &> /dev/null; then
    echo "cargo-edit not found. Installing..."
    cargo install cargo-edit
fi

# Ensure the PATH includes Cargo bin directory
export PATH="$HOME/.cargo/bin:$PATH"

# Get the short commit hash
SHORT_HASH=$(git rev-parse --short HEAD)

# Extract the current version from Cargo.toml
CURRENT_VERSION=$(grep '^version =' Cargo.toml | sed 's/version = "//;s/"$//')

# Separate version components
CURRENT_VERSION=$(echo "$CURRENT_VERSION" | cut -d'+' -f1)

VERSION="${CURRENT_VERSION}-alpha.${SHORT_HASH}"

# Print the new version
echo "Current version: $VERSION"

# Print Cargo.toml before modification
echo "Cargo.toml before modification:"
cat Cargo.toml

# Update Cargo.toml with the new version
sed -i "s/^version = .*/version = \"$VERSION\"/" Cargo.toml

# Print Cargo.toml after modification
echo "Cargo.toml after modification:"
cat Cargo.toml

# Optionally, update Cargo.lock (if needed)
#cargo update -p PlaygroundMR01 --precise "$VERSION"

# Print Cargo.lock after modification
#echo "Cargo.lock after modification:"
#cat Cargo.lock
