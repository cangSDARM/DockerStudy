#GO 也称为Golang

# 基于Dockerfile
	#Dockerfile
		FROM golang:1.6
		RUN mkdir -p /go/src/app
		WORKDIR /go/src/app
		CMD ["go-wrapper", "run"]
		ONBUILD COPY . /go/src/app
		ONBUILD RUN go-wrapper download
		ONBUILD RUN go-wrapper install
	docker build -t go-go .
	docker run -it --rm --name go-compiler go-go
	#只编译不运行
	docker run --rm -v "$(pwd)":/usr/src/app -w /usr/src/app golang:1.6 go build -v _/usr/src/app

# 容器化GO项目
	mkdir outyet
	cd ./outyet
	#使用go get下载
	go get github.com/golang/example/outyet
	cd example-master/outyet
	#Dockerfile
		FROM golang
		ADD . /go/src/github.com/golang/example/my-go
		RUN go install github.com/golang/example/my-go
		#设置容器自动运行
		ENTRYPOINT /go/bin/my-go-app
		EXPOSE 8080
	docker build -t outyet .
	docker run -p 8080:8080 --name test --rm outyet
	#http://localhost:8080

#BEEGO
#GO的开源框架

#GOGS
#Git服务

# 基于官方镜像
	docker run --rm --name gogs gogs/gogs
	docker stop gogs; docker rm gogs
