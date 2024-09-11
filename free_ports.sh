#!/bin/bash

# Check and free ports for ZMQ (5555 and 5556)
for port in 5555 5556; do
    pid=$(lsof -ti:$port)
    if [ -n "$pid" ]; then
        echo "Port $port is in use by PID $pid. Terminating the process..."
        kill -9 $pid
    else
        echo "Port $port is free."
    fi
done

# Check and free Ganache port (8545)
ganache_port=8545
ganache_pid=$(lsof -ti:$ganache_port)
if [ -n "$ganache_pid" ]; then
    echo "Port $ganache_port is in use by PID $ganache_pid. Terminating the process..."
    kill -9 $ganache_pid
else
    echo "Port $ganache_port is free."
fi
	
