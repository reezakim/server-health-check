#!/bin/bash

time_server=$(TZ='Asia/Jakarta' date "+%A,%d-%m-%Y %H:%M:%S")
disk_usage=$(df -h / | grep /dev | awk '{print $5}' | tr -d "%")
idle_cpu=$(top -bn1 | grep "Cpu" | awk -F ',' '{print $4}' | awk '{print $1}' | cut -d '.' -f1)
usage_cpu=$(( 100 - idle_cpu ))
total_mem=$(free -m | grep "Mem" | awk '{print $2}')
usage_mem=$(free -m | grep "Mem" | awk '{print $3}')
percent_usage_mem=$(( usage_mem * 100 / total_mem ))
echo "[$time_server] Disk: $disk_usage% | Memory: $percent_usage_mem% | CPU: $usage_cpu%" | tee -a healthcheck.log
