#GCC (GNU Compiler Collection)
#由GNU开发的编程语言编译器

# 基于Dockerfile
	#Dockerfile
		FROM gcc:4.9
		COPY . /usr/src/myapp
		WORKDIR /usr/src/myapp
		#通过将编译指令写在Dockerfile里构建, 运行此镜像即可启动程序
		RUN gcc -o myapp main.c
		CMD ["./myapp"]
	docker build -t gcc-c .
	docker run -it --rm --name gcc-compiler gcc-c
	#只编译不运行
	#编译当前目录, 生成可执行文件到/usr/src/myapp中
	docker run --rm -v "$(pwd)":/usr/src/myapp -w /usr/src/myapp gcc gcc -o myapp main.c


#LLVM (Low Level Virtual Machine)
#基于SSA的编译策略

# 基于官方镜像
	docker pull imiell/llvm


#Clang
#Apple公司的基于LLVM的编译器

# 基于官方镜像
	docker pull bowery/clang