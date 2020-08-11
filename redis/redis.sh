#!/bin/bash
#Redis服务部署过程
#redis version:3.2.9
# author：yushui

#设置安装路径
dir=/home/dpan/soft
#redis启动端口
redis_port=6379
#IP地址
redis_ip=192.168.67.205
#设置redis密码
#redis_passwd=Ocean@sofT@34769

#maxmemory=8
#--------------------------------------------------------------------
echo "---------------------------------------开始安装redis------------------------------------"
#安装依赖包
echo "依赖包安装中,请稍等..."
yum -y install gcc gcc-c++ wget > /dev/null 2>&1
[ $? -eq 0 ] && echo "依赖包已安装!"
#下载Redis源码包
cd $dir/redis
#wget http://source.goyun.org:8000/source/Redis/redis-3.2.9.tar.gz > /dev/null 2>&1

#解压&&编译&&安装
echo "正在解压编译安装..."
tar -zxvf redis-3.2.9.tar.gz > /dev/null 2>&1
mv redis-3.2.9 /usr/local/redis
cd $dir
rm -rf redis.zip
cd /usr/local/redis
make > /dev/null 2>&1 
make install > /dev/null 2>&1
[ $? -eq 0 ] && echo "Redis已安装!"

#切换到utils⽬目录下，执⾏行行redis初始化脚本install_server.sh
cd /usr/local/redis/utils
echo $redis_port | ./install_server.sh > /dev/null 2>&1

 #添加redis服务⽂文件
cat > /etc/systemd/system/redis_$redis_port.service <<EOF
[Unit]
Description=Redis on port $redis_port
[Service]
Type=forking
ExecStart=/etc/init.d/redis_$redis_port start
ExecStop=/etc/init.d/redis_$redis_port stop
[Install]
WantedBy=multi-user.target
EOF
[ $? -eq 0 ] && echo "Redis服务文件已添加!"
[ $? -eq 0 ] && echo "配置文件：/etc/systemd/system/redis_$redis_port.service"
#配置⽂文件修改
#vim /etc/redis/$redis_port.conf
cat >> /etc/redis/$redis_port.conf << EOF
#bind $redis_ip
#requirepass $redis_passwd
#save ""
#maxmemory $maxmemoryG 
#服务器器内存的2/3 
#maxmemory-policy noeviction
EOF
sed -i 'swprotected-mode yeswprotected-mode nowg' /etc/redis/$redis_port.conf
[ $? -eq 0 ] && echo "配置文件已修改!"
systemctl daemon-reload
systemctl start redis_$redis_port.service
systemctl restart redis_$redis_port.service
[ $? -eq 0 ] && echo "配置文件：/etc/redis/$redis_port.conf"

echo "redis_$redis_port状态为:`systemctl status redis_$redis_port.service | awk -F " " ' {print $1} {print $3} '|grep running`"

echo "---------------------------------------redis部署完成------------------------------------"


