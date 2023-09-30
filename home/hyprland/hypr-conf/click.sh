enabled=$(<~/.click.temp)
if [[ "${enabled}" == true ]] ; then
  echo "false" >| ~/.click.temp
else
  echo "true" >| ~/.click.temp
  while true; do
    xdotool click --repeat 4 --delay 62 1
    enabled=$(<~/.click.temp)
    if [[ $enabled == false ]]; then
      break
    fi
  done
fi
