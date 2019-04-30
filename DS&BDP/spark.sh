#SPARK 大数据处理框架
#体系架构包括: 数据存储(HDFS), API(Scala, Python), 管理框架(Stand-alone, YARN)

#基于官方镜像
	docker pull sequenceiq/spark:1.6.0
	#内置了Dockerfile
	docker build --rm -t sequenceiq/spark:1.6.0
	#需要映射RARN UI接口
	docker run -it -p 8088:8088 -p 8042:8042 -h sandbox sequenceiq/spark:1.6.0 bash
	#伪终端, 查看namenode日志等
		cat /usr/local/hadoop/logs/hadoop-root-namenode-sandbox.out
	#基于YARN集群部署Spark
		#YARN客户端模式
		#SparkContext运行于客户端进程中, 应用的master仅处理YARN的资源管理请求

		#YARN集群模式
		#Spark driver驱动程序运行于master进程中, 由YARN从集群层面管理