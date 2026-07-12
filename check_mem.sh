#!/bin/bash

total_mem=$(free -m | grep "Mem" | awk '{print $2}')
usage_mem=$(free -m | grep "Mem" | awk '{print $3}')

echo "Penggunaan Memori anda: $(( $usage_mem * 100 / $total_mem ))%"
