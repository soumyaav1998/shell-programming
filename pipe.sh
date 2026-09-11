cat "test-file.txt" | grep -i "o" | sort | uniq

# If output of any command before | is failing i.e having an stderr stream, it is ignored by the pipe command and
# lets next command to run, this is wrong hence we need to use pipefail
