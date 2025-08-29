.PHONY: install
install:
	poetry install

.PHONY: run-server
run-server:
	poetry run python -m src.manage runserver

.PHONY: migrate
migrate:
	poetry run python -m src.manage migrate

.PHONY: migragions
migragions:
	poetry run python -m src.manage makemigrations

.PHONY: createsuperuser
createsuperuser:
	poetry run python -m src.manage createsuperuser	

.PHONY: test
test:
	poetry run python -m src.manage test

.PHONY: update
update: install migrate ;
