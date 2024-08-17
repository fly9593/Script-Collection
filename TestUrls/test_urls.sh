#!/bin/bash

# 超时时间设置
CONNECT_TIMEOUT=10
MAX_TIME=20

# URL 列表
URL_LIST=(
    "https://mirror.gcr.io"
    "https://docker.registry.cyou"
    "https://docker-cf.registry.cyou"
    "https://dockercf.jsdelivr.fyi"
    "https://docker.jsdelivr.fyi"
    "https://dockertest.jsdelivr.fyi"
    "https://mirror.aliyuncs.com"
    "https://dockerproxy.com"
    "https://mirror.baidubce.com"
    "https://docker.m.daocloud.io"
    "https://docker.nju.edu.cn"
    "https://docker.mirrors.sjtug.sjtu.edu.cn"
    "https://mirror.gcr.io"
    "https://rqvg4v5d.mirror.aliyuncs.com"
    "https://dockerproxy.com"
    "https://docker.m.daocloud.io"
    "https://reg-mirror.qiniu.com"
    "https://registry.docker-cn.com"
    "http://hub-mirror.c.163.com"
    "https://mirror.gcr.io"
    "https://docker.registry.cyou"
    "https://docker-cf.registry.cyou"
    "https://dockercf.jsdelivr.fyi"
    "https://docker.jsdelivr.fyi"
    "https://dockertest.jsdelivr.fyi"
    "https://mirror.aliyuncs.com"
    "https://dockerproxy.com"
    "https://mirror.baidubce.com"
    "https://docker.m.daocloud.io"
    "https://docker.nju.edu.cn"
    "https://docker.mirrors.sjtug.sjtu.edu.cn"
)

# 函数：移除数组中的重复元素
remove_duplicates() {
    local array=("$@")
    local unique_array=()
    local item

    for item in "${array[@]}"; do
        if [[ ! " ${unique_array[@]} " =~ " $item " ]]; then
            unique_array+=("$item")
        fi
    done

    echo "${unique_array[@]}"
}

# 移除 URL_LIST 中的重复元素
URL_LIST=($(remove_duplicates "${URL_LIST[@]}"))

# 用于存储成功的输出
successful_responses=()

# 批量测试每个 URL
for URL in "${URL_LIST[@]}"; do
    echo "Testing $URL..."
    response=$(curl -I --connect-timeout $CONNECT_TIMEOUT -m $MAX_TIME $URL 2>/dev/null | head -n 1)
    
    if [[ -z "$response" ]]; then
        echo -e "$URL \e[31m not reachable or timed out.\e[0m"
    else
        echo -e "$URL \e[33m response: $response\e[0m"
        reachable_responses+=("$URL response: $response")
    fi
    
    echo "---------------------------------"
done

# 输出成功的请求
if [[ ${#reachable_responses[@]} -gt 0 ]]; then
    echo "reachable responses:"
    for responses in "${reachable_responses[@]}"; do
        echo -e "\e[33m$responses\e[0m"
    done
fi
