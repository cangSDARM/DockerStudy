#MySQL

#使用官方镜像
	# -e 重写ENV, 指定MySQL密码
	docker run -d --name mysql-server -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123 mysql:latest
	#CLI工具修改配置
	docker run -it --link mysql-server:sql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
	#作为客户端, 链接非Docker或远程的MySQL实例
	docker run -it --rm mysql mysql -h mysql.host -u mysql-user -p
	#访问容器内部系统
	docker exec -it mysql-server bash
	#查看日志
	docker logs mysql-server
	#使用自定义配置(.cnf)
	docker run --name mysql-server -v /my/custom:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=123 -d mysql
	#不使用.cnf配置(以配置编码为utf8mb4为例)
	docker run --name mysql-server -e MYSQL_ROOT_PASSWORD=123 -d mysql --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
	#查看可用配置选项列表
	docker run -it --rm mysql --verbose --help