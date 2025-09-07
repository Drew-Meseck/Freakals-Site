.PHONY: install
install:
	poetry install

.PHONY: run-server
run-server:
	poetry run python -m src.manage runserver

.PHONY: migrate
migrate:
	poetry run python -m src.manage migrate

.PHONY: migrations
migrations:
	poetry run python -m src.manage makemigrations

.PHONY: createsuperuser
createsuperuser:
	poetry run python -m src.manage createsuperuser

.PHONY: test
test:
	poetry run python -m src.manage test

.PHONY: update
update: install migrate ;

.PHONY: lint
lint:
	poetry run pre-commit run --all-files

.PHONY: up-dependencies-lin
up-dependencies-lin:
	test -f .env || touch .env
	docker compose -f docker-compose.dev.yml up --force-recreate db

.PHONY: up-dependencies-win
up-dependencies-win:
	if not exist .env type nul > .env
	docker compose -f docker-compose.dev.yml up --force-recreate db
