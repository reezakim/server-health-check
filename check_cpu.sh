#!/bin/bash

idle_cpu=$(top -bn1 | grep "Cpu" | awk -F ',' '{print $4}' | awk '{print $1}' | cut -d '.' -f1)
usage_cpu=$(( 100 - idle_cpu ))

echo "Penggunaan CPU anda: $usage_cpu%"

