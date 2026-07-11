#!/bin/bash
if [ -z "$1" ]; then
	echo "Error 409"
	exit 1
elif [ "$1" = "start" ]; then
	echo "Menjalankan Service..."
	exit 0
elif [ "$1" = "stop" ]; then
        echo "Menhentikan Service..."
        exit 0
else
	echo "Perintah Tidak dikenali"
	exit 2
fi
