#!/bin/sh
#
#
set -ex
bin="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

# set a default build -> 0 for when it doesn't exist
CIRCLE_BUILD_NUM=${CIRCLE_BUILD_NUM:-0}

# epoch to use for -revision
epoch=$(date +%s)

case $CIRCLE_BRANCH in
"master")
  CHANNEL="release"
  ;;
"stage")
  CHANNEL="stage"
  ;;
"yolo")
  CHANNEL="yolo"
  ;;
*)
  CHANNEL="dev"
  ;;
esac

shortname="wp-cli-0.x"
name="$shortname-$CHANNEL"

version=$(cat $bin/../VERSION.txt)
iteration="$(date +%Y%m%d%H%M)"
arch='x86_64'
url="https://github.com/pantheon-systems/${shortname}"
vendor='Pantheon'
description='wp-cli: Pantheon rpm containing commandline tool for WordPress'
install_prefix="/opt/pantheon/$shortname"

download_dir="$bin/../build"

# We wastefully re-download the same file for each version of Fedora. Oh well.
rm -rf $download_dir
mkdir -p $download_dir
curl -L -f https://github.com/wp-cli/wp-cli/releases/download/v${version}/wp-cli-${version}.phar --output $download_dir/wp-cli.phar

fpm -s dir -t rpm  \
    --package "${name}-${version}-${iteration}.${arch}.rpm" \
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
