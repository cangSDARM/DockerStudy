#REDIS 内存数据库
#REmote DIctionary Server

#基于官方镜像
	docker run --name redis-server redis:latast
	docker exec -it redis-server bash
	#伪终端
		uptime
		free
		#查看环境变量配置
		env
		ps -ef
	#使用CLI工具直接启动REDIS命令行
	docker run -it --link redis-server:db --entrypoint redis-cli redis -h db
	#conf
	docker run -v /myredis/conf/redis.conf:/usr/local/etc/redis/redis.conf --name redis-server redis redis-server /usr/local/etc/redis/redis.conf