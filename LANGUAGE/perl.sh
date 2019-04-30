# PERL
# 动态解释型的脚本语言, 常用于系统管理和文件处理以及Web方案的胶水语言

# 基于Dockerfile
	#Dockerfile
		FROM perl:5.20
		COPY . /usr/src/app
		WORKDIR /usr/srp/app
		CMD ["perl", "./run.pl"]
	docker build -t perl-p .
	docker run --rm -it --name perl-compiler ruby-rb
	#挂载Perl项目
	docker run -it --rm --name perl-running -v "$(pwd)":/usr/src/myapp -w /usr/src/myapp perl:5.20 perl run.pl
