#!/bin/bash

check_disk() {
	disk_usage=$(df -h / | grep /dev | awk '{print $5}' | tr -d "%")
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

echo "[$time_server] Penggunaan - Disk: $disk_result% | Memory: $mem_result% | CPU: $cpu_result%" | tee -a healthcheck.log
