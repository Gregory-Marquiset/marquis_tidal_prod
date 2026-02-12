IMAGE := strudel-local
CONTAINER := strudel-local
PORT := 4321

.PHONY: help build run stop restart logs sh clean

help:
	@echo "Targets:"
	@echo "  build    Build the Docker image ($(IMAGE))"
	@echo "  run      Run Strudel on http://127.0.0.1:$(PORT)"
	@echo "  stop     Stop the running container"
	@echo "  restart  Stop then run"
	@echo "  clean    Remove container + image"

build:
	docker build -t $(IMAGE) .

run:
	@docker rm -f $(CONTAINER) >/dev/null 2>&1 || true
	docker run --name $(CONTAINER) --rm -it -p $(PORT):4321 $(IMAGE)

stop:
	@docker rm -f $(CONTAINER) >/dev/null 2>&1 || true

restart: stop run

clean: stop
	@docker rmi -f $(IMAGE) >/dev/null 2>&1 || true
