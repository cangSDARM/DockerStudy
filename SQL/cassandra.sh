#CASSANDRA 分布式数据库
#支持分散的数据存储, 引入了P2P技术
#类似: HBase

#使用官方镜像
	#服务器端口9160 CQL默认本地服务端口9042
	docker run --name cassandra-server -p 9160:9160 -d cassandra:latest
	#配置集群
		#单机模式(多个实例在同一台机器)
		docker run --name cassandra-server-2 -d -e caSSANDRA_SEEDS="$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' cassandra-server)" cassandra:latest
		#链接集群
		docker run --name cassandra-server-2 -d --link cassandra-server:cassandra cassandra:latest
		#多机模式(多个实例分布于多个机器)
		#需要配置IP广播地址和Gossip端口(7000)
		docker run --name cassandra-server -d -e CASSANDRA_BROADCAST_ADDRESS=192.168.0.2 -p 7000:7000 cassandra:latest
		#第二台
		docker run --name cassandra-server-2 -d -e CASSANDRA_BROADCAST_ADDRESS=192.168.0.3 -p 7000:7000 -e CASSANDRA_SEEDS=192.168.0.2 cassandra:latest