#STORM 实时流计算框架
#和Hadoop相似, 但Hadoop的MapReduce完成处理即会结束; topology则永远等待消息处理

# 基于官方镜像
	git clone https://github.com/denverdino/docker-storm.git
	cd docker-swarm/local
	#使用yml文件描述
	#构建测试镜像
	docker-compose build
	#部署Storm应用
	docker-compose up -d -p 8080:8080
	#伸缩supervisor数量
	docker-compose scale supervisor=3
	#启动topolgy服务提交更新的拓扑
	docker-compose start topology
