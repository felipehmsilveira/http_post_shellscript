#!/bin/sh
# script que manda requisição até que o staus esperado ser retornado
EXPECTED_STATUS=200
INTERVAL=10

CURRENT_STATUS=0
while [ $CURRENT_STATUS != $EXPECTED_STATUS ]
do
	echo "$(date '+%d/%m/%Y %H:%M:%S') request..."
	CURRENT_STATUS=$(curl -s -o /dev/null -w '%{http_code}' -X POST 'https://httpbin.org/status/200' \
	-H 'Content-Type: application/json' \
	-d '{"zip_code":"15090080","products":[{"product_id":"202940000","quantity":1}]}')
	
	echo "$(date '+%d/%m/%Y %H:%M:%S') status $CURRENT_STATUS"
	

	if [ $CURRENT_STATUS = $EXPECTED_STATUS ]; then
		echo 'Sucesso!'
		sleep $INTERVAL
	fi

	if [ $CURRENT_STATUS != $EXPECTED_STATUS ]; then
		sleep $INTERVAL
	fi
done

notify-send "Status esperado retornado" "Uma requisição retornou o status $EXPECTED_STATUS"