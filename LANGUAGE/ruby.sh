# 基于Dockerfile
	#Dockerfile
		FROM ruby:2.1.2-onbuild
		CMD ["./run.rb .rb"]
	docker build -t ruby-rb .
	docker run --rm -it --name ruby-compiler ruby-rb
	#必须要有Gemfile.lock文件
	docker run --rm -v "$(pwd)":/usr/src/app -w /usr/src/app ruby:2.1.2 bundle install --system
	#挂载Ruby项目
	docker run -it --rm --name ruby-running -v "$(pwd)":/usr/src/myapp -w /usr/src/myapp ruby:2.1.2 ruby run.rb

# JRuby
# 类似于Python的Jython, 可以运行于JVM上并支持java接口和类

# 基于Dockerfile
	#Dockerfile
		FROM jruby:1.7.24-onbuild
		CMD ["./run.rb"]
	docker build -t jruby-rb .
	#必须要有Gemfile.lock文件
	docker run --rm -v "$(pwd)":/usr/src/app -w /usr/src/app jruby:1.7.24 bundle install --system
	#挂载JRuby项目
	docker run -it --rm --name jruby-running -v "$(pwd)":/usr/src/myapp -w /usr/src/myapp jruby:1.7.24 jruby run.rb

# Ruby on Rails
# 是Ruby开发的网络框架

# 基于Dockerfile
	#Dockerfile
		FROM ruby:2.3
		# throw erros if Gemfile has been modified since Gemfile.lock
		RUN bundle config --global frozen 1
		RUN mkdir -p /usr/src/app
		WORKDIR /usr/src/app

		ONBUILD COPY Gemfile /usr/src/app
		ONBUILD COPY Gemfile.lock /usr/src/app/
		ONBUILD RUN bundle install
		ONBUILD COPY . /usr/src/app
		EXPOSE 3000
	docker build -t rails-rb .
	docker run --name rails-compiler -d -p 3000:3000 rails-rb
# 使用Compose (RoR+PostgreSQL)
	#Dockerfile
		FROM ruby:2.2.0
		RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
		RUN mkdir /code
		WORKDIR /code
		ADD Gemfile /code/Gemfile
			#Gemfile:
				source 'https://rubygems.org'
				gem 'rails', '4.2.0'
		ADD Gemfile.lock /code/Gemfile.lock
		RUN bundle install
		ADD . /code
	#docker-compse.yml
		version:'2'
		services:
			db:
				image: postgres
			web:
				build: .
				command: bundle exec rails s -p 3000 -b '0.0.0.0'
				volumes:
					- .:/myapp
				ports:
					- "3000:3000"
				depends_on:
					- db
	docker-compse run web rails new . --force --database=postgresql --skip-bundle
