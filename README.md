# System Health Monitor
A lightweight Bash script to monitor system performance by tracking CPU, memory, and disk usage. The script logs system metrics and generates warnings when usage exceeds defined thresholds.
---
## Table of Contents
* [Overview](#overview)
* [Features](#features)
* [File Structure](#file-structure)
* [How It Works](#how-it-works)
* [Thresholds](#thresholds)
* [Dependencies](#dependencies)
* [Installation](#installation)
* [Usage](#usage)
* [Automation](#automation)
* [Example Output](#example-output)
* [Future Improvements](#future-improvements)
---
## Overview
This script helps monitor system health by collecting:
* CPU usage
* Memory usage
* Disk usage
All data is logged with timestamps, making it useful for tracking system performance over time.
---
## Features
* Real-time system resource monitoring
* Timestamped logging
* Lightweight and easy to use
---
## File Structure
```id="r8k2xm"
.
├── system_monitor.sh
├── system.log
└── README.md
```
* `system_monitor.sh`: Main monitoring script
* `system.log`: Log file where system metrics and warnings are stored
---
## How It Works
### 1. Log File
The script writes output to:
```id="n5v1zp"
/home/system-health-monitor/system.log
```
---
### 2. Timestamp
The current date and time are captured using:
```bash id="q1m4ls"
date "+%Y-%m-%d %H:%M:%S"
```
---
### 3. CPU Usage
```bash id="f3k7wd"
top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}'
```
* Retrieves CPU statistics
* Calculates active usage from idle percentage
---
### 4. Memory Usage
```bash id="p9z6ha"
free | awk '/Mem/ {printf "%.2f", $3/$2 * 100}'
```
* Calculates percentage of used memory
---
### 5. Disk Usage
```bash id="v2t8qy"
df / | awk 'NR==2 {print $5}' | sed 's/%//'
```
* Extracts disk usage for the root partition
---
### 6. Logging
```bash id="w6c3xn"
echo "$DATE | CPU: $CPU% | MEM: $MEM% | DISK: $DISK%" >> $LOGFILE
```
* Appends system metrics to the log file
---
### 7. Warning Checks
#### CPU
```bash id="y4h2rf"
if (( $(echo "$CPU > 80" | bc -l) ));
```
#### Memory
```bash id="z7n5ku"
if (( $(echo "$MEM > 75" | bc -l) ));
```
#### Disk
```bash id="x8j1mv"
if [ "$DISK" -gt 85 ];
```
Warnings are written to the log file when thresholds are exceeded.
---
## Thresholds
| Resource | Warning Level |
| -------- | ------------- |
| CPU      | > 80%         |
| Memory   | > 75%         |
| Disk     | > 85%         |
---
## Dependencies
Ensure the following tools are installed:
* `top`
* `free`
* `df`
* `awk`
* `sed`
* `bc`
---
## Installation
1. Clone the repository:
```bash id="t3k8vz"
git clone https://github.com/Kritigyamaru/system-health-monitor.git
```
2. Navigate to the project directory:
```bash id="m1p9qx"
cd system-health-monitor
```
3. Make the script executable:
```bash id="c6w2fa"
chmod +x system_monitor.sh
```
---
## Usage
Run the script manually:
```bash id="b7r4ld"
./system_monitor.sh
```
Logs will be written to:
```id="g5y2ns"
/home/system-health-monitor/system.log
```
---
## Automation
To run the script automatically using cron:
1. Open crontab:
```bash id="k9e3tu"
crontab -e
```
2. Add the following line to run the script every five minutes: 
```bash id="u2q6xp"
*/5 * * * * /path/to/system_monitor.sh
```
---
## Example Output
```text id="j4v8sw"
2026-04-06 14:00:00 | CPU: 45% | MEM: 60.25% | DISK: 70%
2026-04-06 14:05:00 WARNING: High CPU Usage!
```
---
## Future Improvements
* Email or notification alerts
* Monitoring additional system metrics
