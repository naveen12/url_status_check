#!/bin/bash

interrupted() {
    echo "Script execution interrupted by the user."
    exit 1
}

trap interrupted SIGINT

check_url() {
    url="$1"
    codes="$2"

    response_code=$(python3 - <<END
import requests
url = "$url"
response = requests.get(url)
print(response.status_code)
END
)

    if [ -z "$codes" ] || echo "$codes" | grep -q "$response_code"; then
        echo "URL $url returns a $response_code status code"
    fi
}

check_urls_in_file() {
    input_file="$1"
    codes="$2"
    while IFS= read -r url; do
        check_url "$url" "$codes"
    done < "$input_file"
}

if [ -z "$1" ]; then
    echo "Usage: $0 <URL or input_file> [status_codes] [output_file]"
    exit 1
fi

input="$1"
codes="$2"
output_file="$3"

if [ -f "$input" ]; then
    if [ -n "$output_file" ]; then
        check_urls_in_file "$input" "$codes" > "$output_file"
    else
        check_urls_in_file "$input" "$codes"
    fi
else
    if [ -n "$output_file" ]; then
        check_url "$input" "$codes" > "$output_file"
    else
        check_url "$input" "$codes"
    fi
fi
