#!/bin/bash
##############################################
# filename: hosts.update.sh
# author: Harold (mail@yaolong.me)
##############################################

os=`uname -s`;
darwin=0;
if [ $os = "Darwin" ]; then
	darwin=1;
fi

hosts_file_start_line=`cat /etc/hosts | sed -n '/# Copyright (c) [0-9]*-[0-9]*, racaljk./=' | head -n 1 | xargs printf "%d"`;

#echo $hosts_file_start_line
hosts_file_end_line=`cat /etc/hosts | sed -n '/# Modified hosts end/=' | tail -n 1 | xargs printf "%d"`;
#echo $hosts_file_end_line

if test $hosts_file_start_line > 1; then
	echo -e "\033[33m除相关hosts内容被替换外，其他自定义hosts将被保留\033[0m"
	if [ $darwin = 1 ]; then
		sudo sh -c "sed -i '' '$hosts_file_start_line,$hosts_file_end_line d' /etc/hosts";
	else
		sudo sh -c "sed -i '$hosts_file_start_line,$hosts_file_end_line d' /etc/hosts";
	fi
else
	echo -e "\033[33m您是第一次更新hosts，原hosts内容将被保留\033[0m"
fi

echo -e "\033[33m正在更新，请稍后...\033[0m"
sudo sh -c "curl -sSL 'https://raw.githubusercontent.com/racaljk/hosts/master/hosts' >> /etc/hosts";

echo -e "\033[32m更新完成！重启浏览器畅想Google吧：https://www.google.com/ncr\033[0m"
