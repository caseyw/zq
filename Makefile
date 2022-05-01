IMAGE=caseyw/zq
TAG=latest

build:
	@docker build -t $(IMAGE):$(TAG) -t $(IMAGE):latest .

test:
	@./scripts/tests.sh

login:
	@docker login --username $(DOCKER_USER) --password $(DOCKER_PASS)

release:
	@docker push $(IMAGE):$(TAG)
	@docker push $(IMAGE):latest
