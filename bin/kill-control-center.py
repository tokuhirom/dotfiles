#!/usr/bin/env python3
import subprocess
import sys
import time

ports = sys.argv[1:]
if len(ports) == 0:
    print(f"Usage: {sys.argv[0]} ports...")
    sys.exit(1)

SLEEP = 3


ncs = []
for port in ports:
    print(f"Stolen {port}")
    subprocess.run(['pgrep', 'ControlCenter'])

    pkill = subprocess.Popen(["pkill", "ControlCenter"])
    ncs.append(subprocess.Popen(['nc', '-l', port]))
    pkill.wait()

    subprocess.run(['pgrep', 'ControlCenter'])

    time.sleep(1)

for nc in ncs:
    print(f"killing {nc}")
    nc.kill()
    print(f"waiting {nc}")
    print(nc.wait())

print("Result:")
for port in ports:
    subprocess.run(["lsof", "-i", f"TCP:{port}"])


