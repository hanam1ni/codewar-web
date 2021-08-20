.PHONY: docker_setup

docker_setup:
	docker-compose -f docker-compose.dev.yml up -d

build: 
	docker build --build-arg DATABASE_URL=$(DATABASE_URL) \
		--build-arg HOST=$(HOST) \
		--build-arg PORT=$(PORT) \
		--build-arg SECRET_KEY_BASE=$(SECRET_KEY_BASE) \
    -t codewar .