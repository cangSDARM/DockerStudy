#ETCD 支持RESTful的集群数据库
0. 说明
    + Etcd使用类似文档结构的操作, 因此每次操作都是基于RESTful路径的操作
    + 名词:
        * wal: (write-ahead-log). 存有日志等内容
        * 键目录: 只能放键值对, 里面不能有目录

1. 安装
    + 二进制文件
        * `curl -L https://github.com/coreos/etcd/releases/download`
        * `tar xzvf etcd-xxxx.tar.gz`
        * `cd etcd-xxxx`
        * `sudo cp etcd* /usr/local/bin`
    + Docker镜像
        * docker pull quay.io/coreos/etcd:vXXX
        * docker run \-p 2379:2379 \-p 2380:2380 \-v /etc/ssl/certs:/etc/ssl/certs/ quay.io/coreos/etcd:vXXX

2. 使用
    `./etcd --vesion`

3. 数据库创建
    + `etcd [OPTIONS]`
        * 通用参数
            - `--name` 设置配置别名
            - `--data-dir "xxx.etcd"` 设置数据存放目录
            - `--wal-dir ' '` 指定wal目录
            - `--max-wals 5` 最大多少wal文件
            - `--snapshot-count '1000'` 多少次提交就存储一次
            - `--max-snapshots 5` 最多保留多少个snapshot
        * 集群参数
            - 跟集群行为有关
            - **用到再查**
        * 安全相关参数
            - 主要用于指定通信时的TLS证书, 密钥配置等
            - **用到再查**
        * 代理参数
            - 主要时当Etcd服务自身仅作为转发客户端请求到指定的Eted集群时用
            - **用到再查**
4. 使用客户端`etcdctl`
    + **主要用于跟Etcd服务打交道而无须RESTful API方式**
    + `etcdctl [全局选项] 命令 [命令选项] [命令参数]`
        * 全局选项
            - `--help, -h` 显示帮助信息
            - **用到再查**
        * 命令
            - 数据类操作
                + 键值操作
                    * `etcdctl set /db/key value` 设置键值对
                    * `etcdctl get /db/key` 获取键值对
                    * `etcdctl update /db/key newValue` 更新键值对
                    * `etcdctl mk /db/key value` 创建新的键
                    * `etcdctl rm /db/key` 删除键值对
                    * `etcdctl watch /db/key` 监视键, 若更新则输出新值
                    * `etcdctl exec-watch /db/key -- sh -C 'ls'` 监视键, 若更新执行给定命令
                + 目录操作
                    * `etcdctl ls /db` 列出目录下的内容(和Linux的ls相似)
                    * `etcdctl mkdir /db` 新建指定目录
                    * `etcdctl rmdir /db` 删除空目录
                    * `etcdctl setdir /db` 创建一个键目录
                    * `etcdctl updatedir /db --ttl 100` 配置目录的属性
            - 非数据类操作
                + `etcdctl backup --data-dir deefault.etcd --backup-dir tmp` 备份指定数据的快照, 日志等
                + `etcdctl cluster-health` 查看集群健康状态
                + `etcdctl member list` 通过list, add, remove修改集群中的实例
                + `etcdctl import --snap tmp/snap/xxx-xxx.snap` 导入旧版本的快照文件
                + `etcdctl user add root` 通过add, get, list, remove, grant, revoke, passwd对用户管理
                + `etcdctl role add group` 通过add, get, list, remove, grant, revoke对用户角色管理(和Linux的group类似)
                + `etcdctl auth enable` 是否启用访问验证
5. 集群管理
>   **用到再查**