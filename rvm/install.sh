#!/bin/sh
#
# RVM
#
# This installs RVM

# Check for existing RVM
if test ! -s "$HOME/.rvm/scripts/rvm"
then
  echo "  Installing RVM for you."

  curl -sSL https://get.rvm.io | bash
fi

exit 0
