function devports() {
  local DOCKER_SOCKET="$HOME/.orbstack/run/docker.sock"
  local tmpfile=$(mktemp)

  # Docker containers
  if command -v docker &>/dev/null && DOCKER_HOST="unix://$DOCKER_SOCKET" docker info &>/dev/null 2>&1; then
    DOCKER_HOST="unix://$DOCKER_SOCKET" docker ps --format '{{.Names}}\t{{.Ports}}' 2>/dev/null \
    | while IFS=$'\t' read name ports; do
      echo "$ports" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+|:::[0-9]+|0\.0\.0\.0:[0-9]+' \
      | grep -oE '[0-9]+$' \
      | sort -u \
      | while read port; do
        echo "$port|—|docker|🐳 $name"
      done
    done >> $tmpfile
  fi

  # Regular processes
  lsof -iTCP -sTCP:LISTEN -P -n | grep -v COMMAND | while read line; do
    pid=$(echo $line | awk '{print $2}')
    port=$(echo $line | awk '{print $9}' | grep -oE '[0-9]+$')
    fullcmd=$(ps -p $pid -o command= 2>/dev/null)
    cmd=$(echo $fullcmd | awk '{print $1}' | xargs basename 2>/dev/null)

    case "$cmd" in
      com.docker.*|docker*|orbstack*|launchd|OrbStack|rapportd|ControlCenter) continue ;;
    esac
    case "$fullcmd" in
      *OrbStack*|*orbstack*) continue ;;
    esac

    folder=$(echo $fullcmd | grep -oE '/[^ ]+' | grep -v '^\(/usr\|/bin\|/opt\|/nix\|/sbin\|/System\|/Applications\)' | head -1 | xargs dirname 2>/dev/null)
    if [ -z "$folder" ] || [ "$folder" = "." ]; then
      folder=$(lsof -a -d cwd -p $pid -Fn 2>/dev/null | grep "^n" | head -1 | cut -c2-)
    fi

    echo "$port|$pid|$cmd|$folder"
  done >> $tmpfile

  {
    echo "PORT|PID|COMMAND|FOLDER/CONTAINER"
    echo "-----|------|----------------|------------------------------------"
    sort -t'|' -k1,1n $tmpfile | uniq -f0
  } | column -t -s'|'

  rm -f $tmpfile
}
