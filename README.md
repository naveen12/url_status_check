# url_status_check
This shell script will result provided url status code is 200 or not

Prerequisite:
this script uses python3

script usage

Make the script executable with the command: chmod +x check_urls.sh

Examples:

Checking a single URL for status code 200 (default):

./check_urls.sh https://example.com


Checking a single URL for custom status codes (e.g., 200, 404):

./check_urls.sh https://example.com "200 404"


Checking URLs from a file (urls.txt) for default status code 200 and storing results in an output file (results.txt):

./check_urls.sh urls.txt "404" results.txt


Checking a single URL for custom status codes and storing results in an output file:

./check_urls.sh https://example.com "200 404" result.txt


Sample urls.txt
https://example.com
https://www.google.com
https://www.openai.com
https://github.com
https://www.reddit.com
