# Makefile para web-persualia-plus (sin .ONESHELL, compatible con make de macOS)
SHELL := /bin/bash

.PHONY: help test test_ca test_en test-prod deploy clean

help: ## Muestra este ayuda
	@echo "Comandos:"
	@echo "  make test       -> Limpia y levanta dev en ES"
	@echo "  make test_ca    -> Limpia y levanta dev en CA"
	@echo "  make test_en    -> Limpia y levanta dev en EN"
	@echo "  make test-prod  -> Limpia, build prod y sirve estático"
	@echo "  make deploy     -> Merge de tu rama en main, build y push (MSG='tu commit')"

clean: ## Limpia artefactos de Jekyll/CSS
	@npm run clean

test: ## Dev (ES)
	@npm run clean && npm run dev

test_ca: ## Dev (CA)
	@npm run clean && npm run dev:ca

test_en: ## Dev (EN)
	@npm run clean && npm run dev:en

# Nota: "make test prod" del enunciado se implementa como "make test-prod"
test-prod: ## Build producción y servidor estático
	@npm run clean && npm run build && npm run serve:static

# Deploy: mergea la rama actual en main, build y push
# Usa: make deploy MSG="chore: deploy"
deploy:
	@bash scripts/deploy.sh "$(MSG)"
