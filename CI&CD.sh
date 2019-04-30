#CI
#持续集成(Continuous integration) 通过自动化的构建来完成
#包括自动编译, 自动发布和自动测试, 从而尽快发现错误
#CD
#持续交付(Continuous delivery) 强调产品修改后到上线的流程要敏捷化, 自动化
#甚至细小改变也要尽早部署

#JENKINS
#CI&CD工具. 能实时监控集中存在的错误, 提供日志和提醒功能, 使用图表展示趋势和稳定性
#且使用Pipeline集成多个任务

# 基于官方镜像
	docker pull jenkins
	docker run -p 8080:8080 -p 50000:50000 --name jenkins-server -v ~/jenkins_home:/var/jenkins_home jenkins

#GITLAB
#开源源码管理系统

# 基于官方镜像
	docker pull gitlab/gitlab-ce
	docker run --detach \
		--hostname gitlab.example.com \
		--publish 443:443 --publish 80:80 --publish 23:23 \
		--name gitlab-server \
		--restart always \
		--volume /src/gitlab/config:/etc/gitlab \
		--volume /src/gitlab/logs:/var/log/gitlab \
		--volume /src/gitlab/data:/var/opt/gitlab \
		gitlab/gitlab-ce:latest
