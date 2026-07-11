#!/bin/bash

disk_usage=$(df -h / | grep /dev | awk '{print $5}' | tr -d "%")
if [ "$disk_usage" -ge "90" ]; then
	echo "[CRITICAL] Disk usage: $disk_usage% - Segera hapus file tidak berguna!"
	exit 2
elif [ "$disk_usage" -gt "80" ]; then
	echo "[WARNING] Disk usage: $disk_usage%"
	exit 1
else
	echo "Disk Usage Aman: $disk_usage%"
	exit 0
fi

