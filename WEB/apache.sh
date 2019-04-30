#Apache WEB服务器

# 基于官方apache
	#Docker官方的apache库为httpd
	#Dockerfile内容:
		FROM httpd:latest
		COPY ./public-html /usr/local/apache2/htdocs/
		#public-html下的index.html:
		#+---------------------------------+
		#|<!DOCTYPE html>                  |
		#|<html>                           |
		#|	<head>                         |
		#|		<title>Apache</title>      |
		#|	</head>                        |
		#|	<body>                         |
		#|		<p>hello world</p>         |
		#|	</body>                        |
		#|</html>                          |
		#+---------------------------------+
	docker build -t apache2
	docker run -it --rm --name apache-server -p 80:80 apache2
	# 访问内容
	192.168.31.162:80
# 直接映射目录
	docker run -it --rm --name apache-server -p 80:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd:latest
# 基于自己的sshd
	mkdir apache_ubuntu && cd apache_ubuntu
	touch Dockerfile run.sh
	#run.sh:
		#!/bin/bash
		/usr/sbin/sshd &
		exec apache2 -D FOREGROUND
	mkdir my-app
	cd my-app && touch index.html && cd ..
	#Dockerfile内容:
		FROM SSHUbuntuDokerfile
		MATINTAINER docker_usr (usr@docker.com)
		# 设置所有操作为非交互性的
		ENV DEBIAN_FRONTEND noninteractive
		# 安装
		RUN apt-get -yq install apache2 && rm -rf /var/lib/apt/lists/*
		# 设置系统的时区设置
		RUN echo "Asia/Shanghai" > /etc/timezone && \
			dpkg-reconfigure -f noninteractive tzdata
		# 添加脚本, 设置权限
		ADD run.sh /run.sh
		RUN chmod 755 /*.sh
		# 添加一个web站点, 删掉apache中的示例文件, 并添加软连接到apache服务
		RUN mkdir -p /var/lock/apache2 && mkdir -p /app
		RUN rm -fr /var/www/html && ln -s /app /var/www/html
		COPY my-app/ /app
		# 设置apache的相关变量, run时用-e <Key>=<Value>替代
		ENV APACHE_RUN_USER xxx
		ENV APACHE_RUN_GROUP xxx-web
		ENV APACHE_LOG_DIR /var/log/apache2
		ENV APACHE_PID_FILE /var/run/apache2.pid
		ENV APACHE_RUN_DIR /var/run/apache2
		ENV APACHE_LOCK_DIR /var/lock/apache2
		ENV APACHE_SERVERADMIN admin@localhost
		ENV APACHE_SERVERNAME localhost
		ENV APACHE_SERVERALIAS docker.localhost
		ENV APACHE_DOCUMENTROOT /var/www
		EXPOSE 80	# 继承开放端口, 不继承CMD命令
		WORKDIR /app
		CMD ["/run.sh"]
	docker build -t APACHEUbuntu
	docker run -d -p 22:22 -p 80:80 APACHEUbuntu
	# 配置本地其他网页
	docker run -id -p 80:80 -p 22:22 -e APACHE_SERVERNAME=test -v `pwd`/www:/var/www:ro APACHEUbuntu