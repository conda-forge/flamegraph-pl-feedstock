#!/usr/bin/env bash
set -ex

mkdir -p "${PREFIX}/bin"

# Fix shebang to use 'env perl' instead of absolute path
fix_shebang() {
    sed -i"" -E -e "1s|/usr/bin/perl( -w)?|/usr/bin/env perl|" "$1"
}

# Install the main flamegraph generator
fix_shebang "flamegraph.pl"
install -m 0755 "flamegraph.pl" "${PREFIX}/bin/flamegraph"

# Install all stackcollapse-* scripts
for script in stackcollapse-*.pl; do
    fix_shebang "$script"
    # Remove .pl extension for cleaner command names
    basename="${script%.pl}"
    install -m 0755 "$script" "${PREFIX}/bin/${basename}"
done

# Install difffolded utility
fix_shebang "difffolded.pl"
install -m 0755 "difffolded.pl" "${PREFIX}/bin/difffolded"
