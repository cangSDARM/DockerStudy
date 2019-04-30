# 创建带有SSH服务的镜像


# 基于commit

	docker search -s 10 -f stars=10 ubuntu #搜素被收藏10次以上, 且star次数高于10的镜像
	docker pull ubuntu:14.04
	docker run --name SSHUbuntu -it ubuntu:14.04 /bin/sh
	# 进入伪终端, 并更新apt和安装openssh
	apt-get update; apt-get install openssh-server -y
	# SSH需要有该文件, 创建它
	mkdir -p /var/run/sshd
	# 启动SSH服务
	/usr/sbin/sshd -D
	# 查看监听状态, 22为SSH默认监听端口
	netstat -tunlp
	# 修改SSH服务安全登陆pam限制
	sed -ri 's/session    required    pam_loginuid.so/#session   required    pam_loginuid.so/g' /etc/pam.d/sshd
	# 创建.ssh目录, 复制需要的公钥信息(~/.ssh/id_rsa.pub下, 可由ssh_keygen -t rsa生成)
	mkdir root/.ssh
	vi root/.ssh/authorized_keys
	# 创建自启的SSH服务文件, 并添加执行权限
	vi /run.sh
	#run.sh:
	#+-------------------------+
	#|#!/bin/sh                |
	#|/usr/sbin/sshd -D        |
	#+-------------------------+
	chmod +x run.sh
	# 退出容器
	exit
	# 保存镜像
	docker commit SSHUbuntu ubuntu:14.04sshd
	# 使用镜像, 映射本机10022到22(sshd端口)
	docker run -p 10022:22 -d ubuntu:14.04sshd /run.sh
	docker ps
	# 其他主机(192.168.31.162)访问
	ssh 192.168.31.162 -p 10022

# 基于Dockerfile

	# 创建工作目录
	mkdir sshd_ubuntu
	cd sshd_ubuntu
	# 新建Dockerfile和run.sh
	# run.sh 和上面相同
	touch Dockerfile run.sh
	# 导入密钥
	ssh-keygen -t rsa
	cat ~/.ssh/id_rsa.pub > authorized_keys
	# 编写Dockerfile
	#+--------------------------------------------------------------------------+
	#|From ubuntu:14.04                                                         |
	#|MAINTAINER docker_usr (usr@docker.com)                                    |
	#|                                                                          |
	#|#安装ssh服务                                                               |
	#|RUN apt-get update                                                        |
	#|RUN apt-get install -y openssh-server                                     |
	#|RUN mkdir -p /var/run/sshd                                                |
	#|RUN mkdir -p /root/.ssh                                                   |
	#|#取消pam限制                                                               |
	#|RUN sed -ri 's/session   required   pam_loginuid.so/#session   required \ |
	#| pam_loginuid.so/g' /etc/pam.d/sshd                                       |
	#|#复制文件到对应位置, 并设置执行权限                                          |
	#|ADD authorized_keys /root/.ssh/authorized_keys                            |
	#|ADD run.sh /run.sh                                                        |
	#|RUN chmod 755 /run.sh                                                     |
	#|#开放端口                                                                  |
	#|EXPOSE 22                                                                 |
	#|#设置启动命令                                                              |
	#|CMD ["/run.sh"]                                                           |
	#+--------------------------------------------------------------------------+
	docker build -t SSHUbuntuDokerfile .
	docker run -d -p 10122:22 SSHUbuntuDokerfile
	ssh 192.168.31.162 -p 10122