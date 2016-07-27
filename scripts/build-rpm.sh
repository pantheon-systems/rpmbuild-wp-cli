#!/bin/sh
#
#
set -ex
bin="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

# set a default build -> 0 for when it doesn't exist
CIRCLE_BUILD_NUM=${CIRCLE_BUILD_NUM:-0}

# epoch to use for -revision
epoch=$(date +%s)

shortname="wp-cli0"
name="$shortname"

version=$(cat $bin/../VERSION.txt)
iteration="$(date +%Y%m%d%H%M)"
arch='noarch'
url="https://github.com/pantheon-systems/${shortname}"
vendor='Pantheon'
description='wp-cli: Pantheon rpm containing commandline tool for WordPress'
install_prefix="/opt/pantheon/$shortname"

download_dir="$bin/../build"
target_dir="$bin/../pkgs"

# We wastefully re-download the same file for each version of Fedora. Oh well.
rm -rf $download_dir
mkdir -p $download_dir
curl -L -f https://github.com/wp-cli/wp-cli/releases/download/v${version}/wp-cli-${version}.phar --output $download_dir/wp-cli.phar

mkdir -p "$target_dir"

fpm -s dir -t rpm  \
    --package "$target_dir/${name}-${version}-${iteration}.${arch}.rpm" \
    --name "${name}" \
    --version "${version}" \
    --iteration "${iteration}" \
    --epoch "${epoch}" \
    --architecture "${arch}" \
    --url "${url}" \
    --vendor "${vendor}" \
    --description "${description}" \
    --prefix "$install_prefix" \
    -C build \
    wp-cli.phar
