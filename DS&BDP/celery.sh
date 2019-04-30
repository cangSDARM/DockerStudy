#CELERY 分布式任务处理系统
#输入是一个工作单元, 多个工作者监听队列来实现任务

#基于官方镜像
	#使用Rabbit
	docker run --link rabbitmq-server:rabbit --name celery-worker -d celery:latest
	#检查集群状态
	docker run --link... --rm celery:latest celery status
	#使用Redis
	docker run --link redis-server:redis -e CELERY_BROKER_URL=redis://redis --name celery-worker -d celery:latest
	#检查集群状态
	docker run --link... -e CELERY_BROKER_URL=reids://redis --rm celery:latest celery status
