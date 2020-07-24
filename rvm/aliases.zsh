# unalias rr
rr () {
  echo "Reloading RVM"
  source ~/.rvm/scripts/rvm
  cd `pwd`
}
