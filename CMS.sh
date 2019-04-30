#CMS 内容管理系统(Content Management System)
#提供内容编辑服务的平台程序, 如WordPress和Ghost

#WordPress
#类似的项目还有Drupal; Joomla; Typo3等
#基于PHP和MySQL, 支持多种插件, 有庞大的社区支持

# 使用官方镜像
	docker pull wordpress
	docker run -p 80:80 --name wordpress-server --link mysqldb:mysql -d wordpress
# 使用Compose
	pip install docker-compose
	touch docker-compose.yml
	vm docker-compose.yml
	# docker-compose.yml:
		wordpress:
			image: wordpress
			links:
				- db:mysql
			ports:
				- 80:80
		db:
			image: mariadb
			enviroment:
				MYSQL_ROOT_PASSWORD: pwd
	docker-compose up

#Ghost
#使用JS开发的CMS

# 使用官方镜像
	docker run --name ghost-server -d -p 2368:2368 -v `pwd`/ghost/blog:/var/lib/ghost ghost
