#MEMCACHED 分布式内存对象缓存系统
#基于内存

#基于官方镜像
	docker run -d --name memcached-server memcached
	#指定使用内存大小. (64MB)
	docker run --name memcached-server -d memcached memcached -m 64
