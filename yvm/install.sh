#!/bin/sh
#
# YVM
#
# This installs YVM

# Check for existing YVM
if test ! -s "$(brew --prefix)/opt/yvm/yvm.sh"
then
  echo "  Installing YVM for you."

  if (( $+commands[brew] ))
  then
    brew install tophat/bar/yvm --without-node
  else
    curl -s https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.js | node
  fi


fi

exit 0
