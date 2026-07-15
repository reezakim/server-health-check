#!/bin/bash

check_disk() {
	disk_usage=$(df -h / | awk 'NR==2{print $5}' | tr -d "%")
	echo "$disk_usage"
}

check_mem() {
	total_mem=$(free -m | grep "Mem" | awk '{print $2}')
	usage_mem=$(free -m | grep "Mem" | awk '{print $3}')
	percent_usage_mem=$(( usage_mem * 100 / total_mem ))
	echo "$percent_usage_mem"
}

check_cpu() {
	idle_cpu=$(top -bn1 | grep "Cpu" | awk -F ',' '{print $4}' | cut -d '.' -f1)
	usage_cpu=$(( 100 - idle_cpu ))
	echo "$usage_cpu"
}


time_server=$(TZ='Asia/Jakarta' date "+%a,%d-%m-%Y %H:%M:%S")
disk_result=$(check_disk)
mem_result=$(check_mem)
cpu_result=$(check_cpu)

scan_disk() {
	if [ "$disk_result" -ge "85" ]; then
		echo "[CRITICAL] Disk Usage: $disk_result%"
		return 2
	elif [ "$disk_result" -gt "75" ]; then
		echo "[WARNING] Disk Usage: $disk_result%"
		return 1
	else
		echo "Disk Usage: $disk_result%"
		return 0
	fi
}

scan_mem() {
	if [ "$mem_result" -ge "90" ]; then
		echo "[CRITICAL] Memory Usage: $mem_result%"
		return 2
	elif [ "$mem_result" -gt "75" ]; then
		echo "[WARNING] Memory Usage: $mem_result%"
		return 1
	else
		echo "Memory Usage: $mem_result%"
		return 0
	fi
}

scan_cpu() {
	if [ "$cpu_result" -eq "100" ]; then
		echo "[CRITICAL] CPU Usage: $cpu_result%"
		return 2
	elif [ "$cpu_result" -gt "80" ]; then
		echo "[WARNING] CPU Usage: $cpu_result%"
		return 1
	else
		echo "CPU Usage: $cpu_result%"
		return 0
	fi
}


test_disk=$(scan_disk)
severity_disk=$?
test_mem=$(scan_mem)
severity_mem=$?
test_cpu=$(scan_cpu)
severity_cpu=$?

echo "[$time_server] $test_disk
[$time_server] Severity: $severity_disk
[$time_server] $test_mem
[$time_server] Severity: $severity_mem
[$time_server] $test_cpu
[$time_server] Severity: $severity_cpu" | tee -a ./logs/healthcheck.log

if [ "$severity_disk" -eq "2" ] || [ "$severity_mem" -eq "2" ] || [ "$severity_cpu" -eq "2" ]; then
	exit 2
elif [ "$severity_disk" -eq "1" ] || [ "$severity_mem" -eq "1" ] || [ "$severity_cpu" -eq "1" ]; then
        exit 1
else 
	exit 0
fi
