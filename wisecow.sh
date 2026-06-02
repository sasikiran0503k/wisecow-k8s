#!/bin/bash

SRVPORT=4499
RSPFILE=response.txt

# Consume incoming HTTP headers until blank line
get_api() {
    while read line; do
        [ "$line" = $'\r' ] && break
    done
}

# Handle each request
handleRequest() {
    # Read and discard headers
    get_api

    # Build response with proper headers
    cat <<EOF > $RSPFILE
HTTP/1.1 200 OK
Content-Type: text/html

<pre>
$(fortune | cowsay)
</pre>
EOF

    # Send response back
    cat $RSPFILE
}

# Ensure prerequisites are installed
prerequisites() {
    command -v cowsay >/dev/null 2>&1 || { echo "cowsay not installed"; exit 1; }
    command -v fortune >/dev/null 2>&1 || { echo "fortune not installed"; exit 1; }
}

# Main server loop
main() {
    prerequisites
    while true; do
        # Listen on SRVPORT and handle requests
        nc -l -p $SRVPORT -q 1 | handleRequest
    done
}

main

