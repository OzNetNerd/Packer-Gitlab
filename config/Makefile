PRIVATE-IP := $(shell curl http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC-IP := $(shell curl http://169.254.169.254/latest/meta-data/public-ipv4)

.PHONY: start-gitlab
start-gitlab:
	@sed -i -e 's#'"'"'http://<private_ip>'"'"'#'"'"'http://$(PRIVATE-IP)'"'"'#g' docker-compose.yml; \
        docker-compose up -d; \
        echo ===============================================================;\
        echo Browse to http://$(PUBLIC-IP); \
        echo ;\
        echo Note: Gitlab may take a few minutes to spin up. ;\
        echo Keep reloading intermittently until the website is displayed. ;\
        echo ===============================================================

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