#!/bin/bash

check_url() {
    url="$1"
    response_code=$(python - <<END
import requests
url = "$url"
response = requests.get(url)
print(response.status_code)
END
)
    if [ "$response_code" == "200" ]; then
        echo "URL $url returns a 200 (OK) status code"
    else
        echo "URL $url returns a $response_code status code"
    fi
}

check_urls_in_file() {
    input_file="$1"
    while IFS= read -r url; do
        check_url "$url"
    done < "$input_file"
}

if [ -z "$1" ]; then
    echo "Usage: $0 <URL or input_file>"
    exit 1
fi

if [ -f "$1" ]; then
    check_urls_in_file "$1"
else
    check_url "$1"
fi
