#!/bin/bash

# 函数：安装iperf3
install_iperf3() {
    # 检查是否已安装iperf3
    if ! command -v iperf3 &> /dev/null
    then
        # 如果未安装iperf3，则进行安装
        echo "正在执行apt-get update..."
        apt-get update
        echo "正在执行apt-get install iperf3..."
        apt-get install -y iperf3
        echo "iperf3安装完成。"
    else
        echo "iperf3已经安装。"
    fi
}

# 函数：卸载iperf3
uninstall_iperf3() {
    # 检查是否已安装iperf3
    if command -v iperf3 &> /dev/null
    then
        # 如果已安装iperf3，则进行卸载
        echo "正在卸载iperf3..."
        apt-get remove -y iperf3
        echo "iperf3已卸载。"
    else
        echo "iperf3未安装。"
    fi
}

# 函数：运行iperf3服务器
run_iperf3_server() {
    # 检查iperf3服务器是否已在运行
    if pgrep iperf3 &> /dev/null
    then
        echo "iperf3服务器已经在运行。"
    else
        echo "正在启动iperf3服务器..."
        iperf3 -s &
    fi
}

# 函数：关闭iperf3服务器
stop_iperf3_server() {
    # 检查iperf3服务器是否已在运行
    if pgrep iperf3 &> /dev/null
    then
        echo "正在关闭iperf3服务器..."
        pkill iperf3
        echo "iperf3服务器已关闭。"
    else
        echo "iperf3服务器未运行。"
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
    echo "1: 安装/卸载iperf3"
    echo "2: 启动/关闭iperf3服务器"
    echo "3: 运行iperf3测试"
    echo "0: 退出"
    echo "=============================="
    read -p "请输入您的选择: " choice
    case $choice in
        1)
            echo "请选择操作："
            echo "1: 安装iperf3"
            echo "2: 卸载iperf3"
            echo "0: 返回主菜单"
            read -p "请输入您的选择: " install_choice
            case $install_choice in
                1)
                    install_iperf3
                    ;;
                2)
                    uninstall_iperf3
                    ;;
                0)
                    continue
                    ;;
                *)
                    echo "无效的选择，请输入有效选项。"
                    ;;
            esac
            ;;
        2)
            echo "请选择操作："
            echo "1: 启动iperf3服务器"
            echo "2: 关闭iperf3服务器"
            echo "0: 返回主菜单"
            read -p "请输入您的选择: " server_choice
            case $server_choice in
                1)
                    run_iperf3_server
                    ;;
                2)
                    stop_iperf3_server
                    ;;
                0)
                    continue
                    ;;
                *)
                    echo "无效的选择，请输入有效选项。"
                    ;;
            esac
            ;;
        3)
            echo "请选择操作："
            echo "1: 运行iperf3测试"
            echo "0: 返回主菜单"
            read -p "请输入您的选择: " test_choice
            case $test_choice in
                1)
                    run_iperf3_test
                    ;;
                0)
                    continue
                    ;;
                *)
                    echo "无效的选择，请输入有效选项。"
                    ;;
            esac
            ;;
        0)
            echo "正在退出..."
            exit 0
            ;;
        *)
            echo "无效的选择，请输入有效选项。"
            ;;
    esac
done
