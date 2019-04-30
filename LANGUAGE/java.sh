# 基于Dockerfile
	#Dockerfile
		FROM java:7
		COPY . /usr/src/javaapp
		WORKDIR /usr/src/javaapp
		#将编译指令写在Dockerfile中, 使用此镜像即可启动程序
		RUN javac main.java
		CMD ["java", "main"]
	docker build -t jvm-java
	docker run -it --rm --name java-compiler jvm-java
	#只编译不运行
	docker run -it --rm -v "$(pwd)":/usr/src/javaapp -w /usr/src/javaapp java:7 javac main.java
