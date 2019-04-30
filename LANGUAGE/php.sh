#PHP (Hypertext Preprocessor, 超文本预处理器)

# 基于Dockerfile
	#Dockerfile
		FROM php:5.6-cli
		COPY . /usr/src/myapp
		WORKDIR /usr/src/myapp
		CMD ["php", "./index.php"]
	docker build -t php-p .
	docker run --rm -it --name php-compiler php-p
	#挂载PHP项目
	docker run -it --rm --name php-running -v "$(pwd)":/usr/src/myapp -w /usr/src/myapp php:5.6-cli php index.php

# 配合Apache
	touch php.ini >> cd config
	#Dockerfile
		FROM php:5.6-apache
		COPY src/ /var/www/html/
		COPY config/php.ini /usr/local/lib/
	docker build -t php-app .
	docker run -it --rm --name php-apache php-app
