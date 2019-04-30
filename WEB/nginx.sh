#NGINX 反向代理服务器, 支持https;http;smtp;pop3;imap等协议
#也可作为负载均衡器, http缓存, web服务器等

# 基于官方镜像
	docker run -d -p 80:80 -v `pwd`/www:/usr/share/nginx/html:ro --name nginx-server nginx
# 基于Dockerfile
	#Dockerfile内容:
		FROM nginx
		#MAINTAINER, etc.
		COPY ./www /usr/share/nginx/html
	docker build -t NGINXUbuntu
	docker run -d --name nginx-server NGINXUbuntu