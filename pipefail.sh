#!/bin/bash
set -o pipefail
cat some-file.txt | sort
echo $?
# if pipefail is not passed $? will give exit code of 0 even though there was error in the command in pipe
# if pipefail given then $? will return exit code