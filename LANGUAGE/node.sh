# 基于Dockerfile
	npm init
	#Dockerfile
		FROM node:4-onbuild
		EXPOSE 8888
	docker build -t node-js .
	docker run -it -P node-js
	#运行单个node脚本
	docker run -it --rm --name node-runnig -v "$(pwd)":/usr/src/myapp -w /usr/src/myapp node:0.10 node index.js
