PUBLIC_HOSTNAME := $(shell curl http://169.254.169.254/latest/meta-data/public-hostname)
PRIVATE_HOSTNAME := $(shell curl http://169.254.169.254/latest/meta-data/hostname)
REGISTRY_USER?=testuser
REGISTRY_PASSWORD?=testpassword
REGISTRY_NAME?=registry
REGISTRY_PORT?=5000
CURRENT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: start-gitlab
start-gitlab:
	@sudo sh -c "echo '127.0.0.1   $(PUBLIC_HOSTNAME)' >> /etc/hosts"
	@mkdir -p certs && mkdir -p auth
	@openssl req \
	-newkey rsa:4096 -nodes -sha256 -keyout certs/$(PUBLIC_HOSTNAME).key \
	-subj "/CN=$(PUBLIC_HOSTNAME)" \
	-x509 -days 365 -out certs/$(PUBLIC_HOSTNAME).crt
	@PUBLIC_HOSTNAME=$(PUBLIC_HOSTNAME) docker-compose up -d
	@make start-registry
	@echo ==========================================================================
	@echo Gitlab login:
	@echo http://$(PUBLIC_HOSTNAME)
	@echo
	@echo Docker registry login:
	@echo docker login $(PUBLIC_HOSTNAME):5000
	@echo
	@echo Note: Gitlab may take a few minutes to spin up.
	@echo Keep reloading intermittently until the website is displayed.
	@echo ==========================================================================

.PHONY: start-registry
start-registry:
	@docker run --rm \
	--entrypoint htpasswd \
	registry:2 -Bbn $(REGISTRY_USER) $(REGISTRY_PASSWORD) > auth/htpasswd
	@sudo mkdir -p /etc/docker/certs.d/$(PUBLIC_HOSTNAME):$(REGISTRY_PORT)
	@sudo cp certs/$(PUBLIC_HOSTNAME).crt /etc/docker/certs.d/$(PUBLIC_HOSTNAME)\:$(REGISTRY_PORT)/ca.crt
	@docker run -d \
	-p $(REGISTRY_PORT):5000 \
	--restart=always \
	--name $(REGISTRY_NAME) \
	-v $(CURRENT_DIR)/auth:/auth \
	-e "REGISTRY_AUTH=htpasswd" \
	-e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
	-e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
	-v $(CURRENT_DIR)/certs:/certs \
	-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/$(PUBLIC_HOSTNAME).crt \
	-e REGISTRY_HTTP_TLS_KEY=/certs/$(PUBLIC_HOSTNAME).key \
	registry:2

.PHONY: register-gitlab-runner
register-gitlab-runner:
	@echo Registering Gitlab runner...
	@docker exec -it gitlab-runner \
	gitlab-runner register -n \
	--url http://${PRIVATE_HOSTNAME} \
	--registration-token ${REGISTRATION_TOKEN} \
	--executor docker \
	--description "Gitlab Runner" \
	--docker-image "docker:stable" \
	--docker-privileged \
	--locked=false \
	--docker-volumes /etc/docker/certs.d:/etc/docker/certs.d \
	> /dev/null;