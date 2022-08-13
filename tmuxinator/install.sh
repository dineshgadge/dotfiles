if test ! $(which tmuxinator)
then
  rvm use 3.0.0
  gem install tmuxinator
fi
