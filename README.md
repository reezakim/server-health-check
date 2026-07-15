# Server Check Health

A Bash script that monitors **Disk**, **Memory**, and **CPU** Usage, and shows **CRITICAL** or **WARNING** when usage crosses a threshold.

## About
This script checks disk usage / memory usage / CPU usage on a Linux server and reports the status as OK, WARNING, or CRITICAL to **Log** based on preset thresholds. This project was built to understand how Bash Scripting is used in real-world system administration and DevOps workflows, and to strengthen my problem-solving skills through hands-on practice.
## Prerequisites
- **Bash** (Native on Linux/macOS, or via WSL/Git Bash on Windows)
- **Docker Engine 20.10+** (Optional, for containerized execution)

## Compatibility
This script relies on standard GNU utilities (`df`, `free`, and `top` from the `procps` package). 
It has been fully tested on:
- Debian/Ubuntu (Both native installations and Docker `debian:bookworm-slim` images)

> ⚠️ **Note on Alpine Linux:** This script is **not** out-of-the-box compatible with Alpine Linux (BusyBox) due to differences in `top` and `free` output formats. Modifying the parsing logic is required for Alpine support.

## How To Use
### Option 1: Native Execution
1. Clone this repository to your environment
   ```
   git clone https://github.com/reezakim/server-health-check.git
   cd server-health-check
   ```
2. Give executions permissions to file script 
   ```
   chmod +x healthcheck.sh
   ```
3. Run the script 
   ```
   ./healthcheck.sh
   ```

### Option 2: Run via Docker
1. Build the Docker image
   ```
   docker build -t health-check:latest .
   ```

2. Initialize the log directory (Required - see note below)
   ```
   mkdir -p logs
   ```

3. Run the container
   ```
   docker run --rm -v $(pwd)/logs:/automation/logs health-check:latest
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
