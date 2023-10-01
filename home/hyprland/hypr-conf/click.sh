enabled=$(<~/tmp.test)
if [[ "${enabled}" == true ]] ; then
  echo "false" >| ~/tmp.test
else
  echo "true" >| ~/tmp.test
  while true; do
    xdotool click --repeat 4 --delay 62 1
    enabled=$(<~/tmp.test)
    if [[ $enabled == false ]]; then
      break
    fi
  done
fi
