# Redis-sh

author:yushui

安装redis单节点

## 介绍

redis（Remote Dictionary Server）是一个key-value存储系统。和Memcached类似，它支持存储的value类型相对更多，包括string(字符串)、list(链表)、set(集合)、zset(sorted set --有序集合)和hash（哈希类型）。这些数据类型都支持push/pop、add/remove及取交集并集和差集及更丰富的操作，而且这些操作都是原子性的。在此基础上，redis支持各种不同方式的排序。与memcached一样，为了保证效率，数据都是缓存在内存中。区别的是redis会周期性的把更新的数据写入磁盘或者把修改操作写入追加的记录文件，并且在此基础上实现了master-slave(主从)同步。

官方地址： https://redis.io/ 官方文档地址：https://redis.io/documentation

## 要求

此角色仅在RHEL及其衍生产品上运行。

## 测试环境

ansible `3.2.9`

os `Centos 7.6 X64`

## 需要依赖

gcc gcc-c++ wget 需配置好yum源



