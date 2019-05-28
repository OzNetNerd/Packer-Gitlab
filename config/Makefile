.PHONY: start-gitlab
start-gitlab:
	@docker-compose up -d

.PHONY: register-gitlab-runner
register-gitlab-runner:
	@echo Registering Gitlab runner...
	@docker exec -it gitlab-runner \
	gitlab-runner register -n \
	--url http://gitlab \
	--registration-token ${REGISTRATION_TOKEN} \
	--executor docker \
	--description "Gitlab Runner" \
	--docker-image "docker:stable" \
	--docker-privileged \
	--locked=false \
	> /dev/null;