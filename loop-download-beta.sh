#!/bin/bash

# 设置循环下载标志
loop_download=true

# 循环下载
while [ "$loop_download" = true ]
do
    # 获取用户输入的下载地址和协议类型
    echo "请输入要下载的文件地址："
    read download_url
    echo "请选择要使用的协议类型（IPv4, IPv6）："
    read protocol_type

    # 检查是否存在 wget 命令
    if ! command -v wget &> /dev/null; then
        echo "Error: wget command not found. Please install it and try again."
        exit 1
    fi

    # 下载文件
    if [ "$protocol_type" = "IPv6" ]; then
        # 使用 IPv6 进行下载
        echo "将使用 IPv6 进行下载。"
        wget --no-check-certificate -6 "$download_url" -P ~/Downloads/
    else
        # 如果下载地址不支持 IPv6，则使用 IPv4 进行下载
        if wget --inet6-lookup "$download_url" 2>&1 | grep "Name or service not known"; then
            echo "当前下载地址不支持 IPv6 访问，将使用 IPv4 进行下载。"
            wget --no-check-certificate "$download_url" -P ~/Downloads/
        else
            echo "将使用 IPv4 进行下载。"
            wget --no-check-certificate "$download_url" -P ~/Downloads/
        fi
    fi

    echo "下载完成！"

done

echo "退出下载。"
