#!/bin/bash
LOGFILE="/home/system-health-monitor/system.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")
cpu_usage() {
	top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}'
}
memory_usage() {
	free | awk '/Mem/ {printf "%.2f", $3/$2 * 100}'
}
disk_usage() {
	df / | awk 'NR==2 {print $5}' | sed 's/%//'
}
CPU=$(cpu_usage)
MEM=$(memory_usage)
DISK=$(disk_usage)
echo "$DATE | CPU: $CPU% | MEM: $MEM% | DISK: $DISK%" >> $LOGFILE
if (( $(echo "$CPU > 80" | bc -l) )); then
	echo "$DATE WARNING: High CPU Usage!" >> $LOGFILE
fi
if (( $(echo "$MEM > 75" | bc -l) )); then
	echo "$DATE WARNING: High Memory Usage!" >> $LOGFILE
fi
if [ "$DISK" -gt 85 ]; then 
	echo "$DATE WARNING: Disk Space Critical!" >> $LOGFILE
fi 
