#TOMCAT Servlet容器
#对Servlet的JSP支持, 提供了TOMCAT管理和控制平台, 安全域管理和TOMCAT阀等
#TOMCAT内置了一个WEB服务器, 也可以作为服务器使用

# 基于官网
	docker search tomcat |wc -l		# 查看相关镜像个数
	mkdir tomact_jdk1.6
	cd tomact_jdk1.6/
	touch Dockerfile run.sh
		#run.sh:
			#!/bin/bash
			if [ ! -f /.tomcat_admin_created ]; then
				/create_tomcat_admin_usr.sh
			fi
			/usr/sbin/sshd -D &
			exec ${CATALINA_HOME}/bin/catalina.sh run
	wget http://mirror.bit.edu.cn/apache/tomcat/tomcat-7/v7.0.56/bin/apache-tomcat-7.0.56.zip
	crul #从www.oracle.com下载SUN_JDK
	# Dockerfile文件:
		FROM SSHUbuntu
		#MAINTAINER etc.
		ENV DEBIAN_FRONTEND noninteractive
		RUN echo "Asia/Shanghai" > /etc/timezone && \
			dpkg-reconfigure -f noninteractive tzdata
		RUN apt-get update
		# 安装tomcat用户认证相关
		RUN apt-get install -yq --no-install-recommends wget pwgen ca-certificates && \
			apt-get clean && \
			rm -rf /var/lib/apt/lists/*
		# TOMCAT相关环境变量
		ENV CATALINA_HOME /tomcat
		ENV JAVA_HOME /jdk
		ADD apache-tomcat-7.0.56 /tomcat
		ADD jdk /jdk

		ADD create_tomcat_admin_usr.sh /create_tomcat_admin_usr.sh
			#create_tomcat_admin_usr.sh:
				#!/bin/bash
				if [ -f /.tomcat_admin_created ]; then
					echo "TOMCAT 'admin' usr already created"
					exit 0
				fi
				#generate password
				PASS=${TOMCAT_PASS:-$(pwgen -s 12 1)}
				_word=$( [ ${TOMCAT_PASS} ] && echo "preset" || echo "random" )
				echo "=>Creating and admin usr with a ${_word} password in TOMCAT"
				sed -i -r 's/<\/tomcat-users>//' ${CATALINA_HOME}/conf/tomcat-users.xml
				echo '<role rolename="manager-gui"/>' >> ${CATALINA_HOME}/conf/tomcat-users.xml
				echo '<role rolename="manager-script"/>' >> ${CATALINA_HOME}/conf/tomcat-users.xml
				echo '<role rolename="manager-jmx"/>' >> ${CATALINA_HOME}/conf/tomcat-users.xml
				echo '<role rolename="admin-gui"/>' >> ${CATALINA_HOME}/conf/tomcat-users.xml
				echo '<role rolename="admin-script"/>' >> ${CATALINA_HOME}/conf/tomcat-users.xml
				echo "<user username=\"admin\" password=\"${PASS}\" roles=\"manager-gui, manager-script, manager-jmx, admin-gui, admin-script\"/>" >> ${CATALINA_HOME}/conf/tomcat-users.xml
				echo "</tomcat-users>" >> ${CATALINA_HOME}/conf/tomcat-users.xml
				echo "=>DONE!"
				touch /.tomcat_admin_created
				echo "        admin:${PASS}"
		ADD run.sh /run.sh
		RUN chmod +x /*.sh
		RUN chmod +x /tomcat/bin/*.sh
		EXPOSE 8080
		COM ["/run.sh"]
	docker build -t TOMCATUbuntu
	docker run -d -p 8080:8080 --name tomcat-server TOMCATUbuntu
	docker logs tomcat-server #获取TOMCAT生成的密码
