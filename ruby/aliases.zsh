# alias sc='script/console'
# alias sg='script/generate'
# alias sd='script/destroy'

alias ras='git diff --name-only --staged | egrep "\.rb$" | grep -v db/schema.rb | xargs rubocop -a'
