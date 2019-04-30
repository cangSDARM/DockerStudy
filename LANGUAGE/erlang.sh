#ERLANG 用于构建弹性, 实时, 高并发系统的语言
#通常用于电信, 银行, 电子商务和即时消息

# 基于官方镜像
	docker pull erlang
	docker run -it --rm erlang
	# 运行Erlang脚本
	docker run -it --rm --name erlang-running -v "$PWD":/usr/src/app -w /usr/src/app erlang escript run.erl
