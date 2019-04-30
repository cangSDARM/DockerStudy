#RABBITMQ 支持Advanced Message Queuing Protocol(AMQP)的消息队列实现
#负责在分布式系统中存储和转发消息

#基于官方镜像
	#RabbitMQ数据存储于Node中, 需要指定运行的主机名
	#远程管理和跨容器管理时, 需要设置cookie
	docker run -d --hostname rabbit-my --name rabbitmq-server -e RABBITMQ_ERLANG_COOKIE='secret cookie here' rabbitmq:3
	#使用cookie链接一个实例
	docker run -it --rm --link rabbitmq-server:mq -e RABBITMQ_ERLANG_COOKIE='sercret cookie here' rabbitmq:3 bash
	#伪终端
		rabbitmqctl -n rabbit@rabbit-my list_users
	#使用管控插件(https://container-ip:15672访问)
	docker run -d --hostname... --name... -p 15672:15672 rabbitmq:3-management
	#修改默认用户名及密码, vhost
	docker run -d --hostname... --name... -e RABBITMQ_DEFAULT_USER=usr RABBITMQ_DEFAULT_PASS=pwd RABBITMQ_DEFAULT_VHOST=my_vhost rabbitmq:3-management
