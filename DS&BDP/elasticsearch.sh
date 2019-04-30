#ELASTICSEARCH 搜索服务器
#提供分布式的多租户的全文搜索引擎

# 基于官方镜像
	# 对外服务端口9200, 对内通信端口9300
	docker run -p 9200:9200 9300:9300 -d elasticsearch elasticsearch -Des.node.name="TestNode"
