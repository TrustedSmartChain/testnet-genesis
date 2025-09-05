#!/usr/bin/env sh
# installs the CLI and default node instance
set -e

# DOWNLOAD
tsc="/opt/tsc/bin/tsc"
download_url="https://static.trustedsmartchain.com/node/linux/releases/1.9.0/tsc"
curl $download_url -o $tsc --create-dirs
chmod +x $tsc

# ADD ALIAS
alias='alias tsc="/opt/tsc/bin/tsc"'
if ! grep -Fxq "$alias" ~/.bashrc; then
    echo $alias >> ~/.bashrc
fi
# source ~/.bashrc

$tsc version

# INITIALIZE
set +e
$tsc node init -e testnet
exit_code=$?
set -e
if [ "$exit_code" != 0 ] && [ $exit_code != 99 ]; then
  exit 1
fi

# ACTIVATE
$tsc node activate

# INSTALL SERVICE
$tsc node service install
$tsc node service start
