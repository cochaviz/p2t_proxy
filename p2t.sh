RESPONSE=$(curl 'https://p2t.breezedeus.com/api/pix2text' -X POST \
	-H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/117.0' \
	-H 'Accept: application/json, text/plain, */*' \
	-H 'Accept-Language: en-US,en;q=0.5' \
	-H 'Accept-Encoding: gzip, deflate, br' \
	-H 'Content-Type: multipart/form-data; boundary=---------------------------239283585238148359333436682286' \
	-H 'Origin: https://p2t.breezedeus.com' \
	-H 'DNT: 1' \
	-H 'Connection: keep-alive' \
	-H 'Referer: https://p2t.breezedeus.com/' \
	-H 'Sec-Fetch-Dest: empty' \
	-H 'Sec-Fetch-Mode: cors' \
	-H 'Sec-Fetch-Site: same-origin' \
	-H 'Sec-GPC: 1' \
	-k \
	-F "image=@$(pwd)/$1" \
	-F 'session_id=session--vIfxT-DmqA7x2HjG7kgTrdn8SF26tFJ')

if [ $? -ne 0 ]; then
	exit 1 # failed request
fi

if [ "$RESPONSE" == "Internal Server Error" ]; then
	>&2 echo "Internal server error"
	exit 2 # request successful, but invalid input
fi	

echo "$RESPONSE" | jq -r '.results'
