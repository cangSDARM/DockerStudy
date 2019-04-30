# 基于Dockerfile
	#依赖包文件
	touch requirements.txt
	#Dockerfile
		FROM python:3-onbuild
		CMD ["python3.7", "./main.py"]
	docker build -t python-py .
	docker run -it --rm --name py3-compiler python-py
	#只需运行单个python脚本
	docker run -it --rm --name py3-running -v "$(pwd)":/usr/src/myapp -w /usr/src/myapp python:3 python main.py

#PyPy
#一个python的解释器和即时编译(JIT)工具

# 基于Dockerfile
	touch requirements.txt
	#Dockerfile
		FROM pypy:3-onbuild
		CMD ["pypy3", "./main.py"]
	docker build -t pypy-py .
	docker run -it --rm --name pypy3-compiler pypy-py
	#只需运行单个脚本
	docker run -it --rm --name pypy-running -v "$(pwd)":/usr/src/myapp -w /usr/src/myapp pypy:3 pypy3 main.py