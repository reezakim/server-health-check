# Server Check Health

A Bash script that monitors **Disk**, **Memory**, and **CPU** Usage, and shows **CRITICAL** or **WARNING** when usage crosses a threshold.

## About
---
This script checks disk usage / memory usage / CPU usage on a Linux server and reports the status as OK, WARNING, or CRITICAL to **Log** based on preset thresholds. This project was built to understand how Bash Scripting is used in real-world system administration and DevOps workflows, and to strengthen my problem-solving skills through hands-on practice.
## Prerequisites
---
- Operating System : Linux Server / WSL
- Installed GIT
## How To Use
---
1. Clone this repository to your environment
   ```
   git clone https://github.com/reezakim/server-health-check.git
   cd server-health-check
   ```
2. Give permissions to file script 
   ```
   chmod +x healthcheck.sh
   ```
3. Run the script 
   ```
   ./healthcheck.sh
   ```

## Example Output :
```
[Tue,14-07-2026 19:04:56] Disk Usage: 7%
[Tue,14-07-2026 19:04:56] Severity: 0
[Tue,14-07-2026 19:04:56] Memory Usage: 19%
[Tue,14-07-2026 19:04:56] Severity: 0
[Tue,14-07-2026 19:04:56] [CRITICAL] CPU Usage: 100%
[Tue,14-07-2026 19:04:56] Severity: 2
```

## Severity Levels
---

| Severity | Meaning  | Exit Code |
|----------|----------|-----------|
| 0        | OK       | 0         |
| 1        | WARNING  | 1         |
| 2        | CRITICAL | 2         |

The script exits with the highest severity level found among the three checks.
This makes it usable in automated environments (e.g. cron jobs) where the exit 
code determines whether an alert or action should be triggered.

Note : Results are saved to the healthcheck.log. Run this command to view them
```
cat healthcheck.log
```
