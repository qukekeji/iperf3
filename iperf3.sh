#!/bin/bash

# 函数：安装iperf3
install_iperf3() {
    # 检查是否已安装iperf3
    if ! command -v iperf3 &> /dev/null
    then
        # 如果未安装iperf3，则安装
        echo "正在安装iperf3..."
        apt-get update
        apt-get install -y iperf3
    else
        echo "iperf3已经安装。"
    fi
}

# 函数：启动iperf3服务器
start_iperf3_server() {
    # 检查iperf3服务器是否已在运行
    if pgrep iperf3 > /dev/null
    then
        echo "iperf3服务器已经在运行，无需重复运行。"
        echo "是否退出iperf3服务器？(Y/N)"
        read -r choice
        if [[ $choice == "Y" || $choice == "y" ]]
        then
            pkill iperf3
            echo "iperf3服务器已退出。"
        fi
    else
        echo "正在启动iperf3服务器..."
        iperf3 -s
    fi
}

# 函数：运行iperf3测试
run_iperf3_test() {
    read -p "请输入服务器IP地址: " server_ip
    echo "正在运行iperf3测试..."
    iperf3 -c $server_ip -t 60
}

# 主菜单
while true
do
    echo "=============================="
    echo "1: 安装iperf3"
    echo "2: 启动/退出iperf3服务器"
    echo "3: 运行iperf3测试"
    echo "4: 退出"
    echo "=============================="
    read -p "请输入您的选择: " choice
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
            echo "正在退出..."
            exit 0
            ;;
        *)
            echo "无效的选择，请输入有效选项。"
            ;;
    esac
done
