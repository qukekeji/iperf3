#!/bin/bash

# Function to install iperf3
install_iperf3() {
    # Check if iperf3 is installed
    if ! command -v iperf3 &> /dev/null
    then
        # Install iperf3 if not installed
        echo "Installing iperf3..."
        apt-get update
        apt-get install -y iperf3
    else
        echo "iperf3 is already installed."
    fi
}

# Function to start iperf3 server
start_iperf3_server() {
    echo "Starting iperf3 server..."
    iperf3 -s &
}

# Function to run iperf3 test
run_iperf3_test() {
    read -p "Enter server IP address: " server_ip
    iperf3 -c $server_ip -t 60
}

# Main menu
while true
do
    echo "=============================="
    echo "1: Install iperf3"
    echo "2: Start iperf3 server"
    echo "3: Run iperf3 test"
    echo "4: Exit"
    echo "=============================="
    read -p "Enter your choice: " choice
    case $choice in
        1)
            install_iperf3
            ;;
        2)
            start_iperf3_server
            ;;
        3)
            run_iperf3_test
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a valid option."
            ;;
    esac
done
