IMAGE := strudel
CONTAINER := strudel
PORT := 4321

.PHONY: build run stop logs clean

build:
	docker build -f Dockerfile -t $(IMAGE) .

run:
	@docker rm -f $(CONTAINER) >/dev/null 2>&1 || true
	docker run --name $(CONTAINER) --rm -it -p $(PORT):80 $(IMAGE)

stop:
	@docker rm -f $(CONTAINER) >/dev/null 2>&1 || true

logs:
	docker logs -f $(CONTAINER)

clean: stop
	@docker rmi -f $(IMAGE) >/dev/null 2>&1 || true
