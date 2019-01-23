#  #!/bin/bash

clear

clear

# elm 19!
elm make src/Main.elm --output static/main.js
# print this because elm doesn't print a message when the link
# step is finally done.
echo build is over now!
