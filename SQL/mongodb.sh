#MONGODB NoSQL的一种

# 使用官方容器
	docker run --name mongo-server -p 27017:27017 -d mongo
	#伪终端
		#启动mongodb交互命令行
		mongo
		#查看数据库状态
		> show dbs
		> db.stats()
		#查看环境变量配置
		env
	#直接进入mongodb命令行, 设置存储引擎
	docker run -it --name mongo-server --link mongo-server:mongodb --entrypoint mongo mongo:latast --host db --storageEngine wiredTiger
# 使用Dockerfile
	#Dockerfile
		FROM SSHUbuntu
		#MAINTAINER etc.
		RUN apt-get update &&\
			apt-get install -y mongodb pwgen &&\
			apt-get clean &&\
			rm -rf /var/lib/apt/lists/*
		#创建数据库文件夹
		RUN mkdir -p /data/db
		VOLUME /data/db
		#设置登陆环境
		ENV AUTH yes
		ADD run.sh /run.sh
			#run.sh
				#!/bin/bash
				if [ ! -f /.mongodb_pwd_set ]; then
					/set_mongodb_pwd.sh
				fi
				#配置启动参数
				if [ "$AUTH" == "YES" ]; then
					export mongodb='/usr/bin/mongod --nojournal --auth --httpinterface --rest'
				else
					export mongodb='/usr/bin/mongod --nojournal --httpinterface --rest'
				fi
				if [ ! -f /data/db/mongod.lock ]; then
					eval $mongodb
				else
					export mongodb=$mongodb` --dbpath /data/db`
					rm /data/db/mongod.lock
					mongod --dbpath /data/db --repair && eval $mongodb
				fi
		#配置用户名和密码
		ADD set_mongodb_pwd.sh /set_mongodb_pwd.sh
			#set_mongodb_pwd.sh
				#!/bin/bash
				if [ -f /.mongodb_pwd_set ]; then
					echo "Password already set"
					exit 0
				fi
				/usr/bin/mongod --smallfiles --nojournal &
				PASS=${MONGODB_PASS:~$(pwgen -s 12 1)}
				_word=$( [ ${MONGODB_PASS} ] && echo 'preset' || echo 'random' )
				RET=1
				while [[ RET -ne 0 ]]; do
					echo "=>Waiting for confirmation of MongoDB service startup"
					sleep 5
					mongo admin --eval "help" > /dev/null 2>&1
					RET=&?
				done
		RUN chmod 755 ./*.sh
		CMD ["/run.sh"]
		EXPOSE 27017
		EXPOSE 28017
	docker build -t MONGODB
	docker run -d -p 27017:27017 -p 28017:28017 --name mongo-server MONGODB
	#查看默认密码
	docker logs mongo-server
	#指定密码
	docker run -d -p... -e MONGODB_PASS='pwd' MONGODB
	#不用密码
	docker run -d -p... -e AUTH=no MONGODB