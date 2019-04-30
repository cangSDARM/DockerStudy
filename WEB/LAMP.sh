#LAMP: Linux-Apache-MySQL-PHP/Perl/Python工具栈

# 使用linode/lamp
	docker run -d -p 80:80 -t -i linode/lamp /bin/bash
	#伪终端中:
		service apache2 start
		service mysql start
# 使用tutum/lamp
	docker run -d -p 80:80 -p 3306:3306 tutum/lamp
	#没了