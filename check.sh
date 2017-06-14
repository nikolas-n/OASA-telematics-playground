#!/bin/bash
#
# Check if script.js has changed

if [ -f script.js ]; then
  curl -s "http://telematics.oasa.gr/js/script.js" > script.js.temp
  check=$(diff script.js script.js.temp)
    if [ "$check" ]; then
      echo "Something changed:" "$check"
      echo "Do you want to overwrite old file? (y/n)"
      read answer
        if [ "$answer" == "y" ]; then
          mv script.js.temp script.js
       fi
    else
      echo "Nothing changed"
    fi
else
  curl -s "http://telematics.oasa.gr/js/script.js" > script.js
fi
