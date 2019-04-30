#R
#面向统计分析和绘图

# 基于官方镜像
	docker pull r-base
	docker run -ti --rm r-base bash
	#伪终端
		Rscript run.R
		R
		>source('/bin/run.R')
		>quit()

# 运行批量模式
	docker run -ti --rm -v "$(pwd)":/src/app -w /src/app -u docker r-base R CMD check .
