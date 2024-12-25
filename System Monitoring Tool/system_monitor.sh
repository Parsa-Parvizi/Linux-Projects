#!/bin/bash

# Function to check CPU usage
check_cpu_usage() {
  cpu_usage=$(top -bn1 | awk '/%Cpu\(s\):/ {print $2}')
  echo "CPU Usage: $cpu_usage%"
}

# Function to check memory usage
check_memory_usage() {
  free -m | awk '/Mem:/ {print $3"/"$2}'
  echo "Memory Usage: $(free -m | awk '/Mem:/ {print $3"/"$2}')"
}

# Function to check disk space usage
check_disk_usage() {
  df -h / | awk '{print $5}' | head -n 2 | tail -n 1
  echo "Disk Usage: $(df -h / | awk '{print $5}' | head -n 2 | tail -n 1)"
}

# Function to check network traffic
check_network_traffic() {
  rx_bytes=$(ifconfig eth0 | grep 'RX bytes' | awk '{print $2}') 
  tx_bytes=$(ifconfig eth0 | grep 'TX bytes' | awk '{print $2}')
  echo "Network Traffic (RX): $rx_bytes bytes"
  echo "Network Traffic (TX): $tx_bytes bytes"
}

# Main loop
while true; do
  clear
  echo "System Monitoring"
  echo "-----------------"
  check_cpu_usage
  check_memory_usage
  check_disk_usage
  check_network_traffic
  echo
  sleep 5 # Update every 5 seconds
done