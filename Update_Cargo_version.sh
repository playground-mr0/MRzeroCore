#!/bin/bash
ls -l Update_Cargo_version.sh
chmod +x Update_Cargo_version.sh

# Get current version with commit hash and date
VERSION=$(git describe --tags --dirty --always --long --abbrev=7)

# Update Cargo.toml with the new version
sed -i "s/^version = \".*\"$/version = \"$VERSION\"/" Cargo.toml

# Update Cargo.lock with the new version (optional)
cargo update -p PlaygroundMR01 --precise "$VERSION"  # Replace 'your-package-name' with your actual package name
