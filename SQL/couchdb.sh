#COUCHDB 面向文档的NoSQL数据库
#以JSON存储数据

#基于官方镜像
	docker run -d --name couchdb-server -p 5984:5984 couchdb
	#link
	docker run --name couchdb-app --link couchdb-server:db couchdb