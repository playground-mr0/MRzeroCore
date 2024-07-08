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

# Print Cargo.toml before modification
echo "Cargo.toml before modification:"
cat Cargo.toml

# Update Cargo.toml with the new version
cargo set-version --version "$VERSION"

# Print Cargo.toml after modification
echo "Cargo.toml after modification:"
cat Cargo.toml

# Optionally, update Cargo.lock (if needed)
cargo update -p PlaygroundMR01 --precise "$VERSION"

# Print Cargo.lock after modification
echo "Cargo.lock after modification:"
cat Cargo.lock
