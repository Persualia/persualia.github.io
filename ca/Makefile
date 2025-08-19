# Makefile para web-persualia-plus (sin .ONESHELL, compatible con make de macOS)
SHELL := /bin/bash

# Detecta comando para abrir navegador
ifeq ($(OS),Windows_NT)
  OPEN_CMD := start
else
  UNAME_S := $(shell uname -s)
  ifeq ($(UNAME_S),Darwin)
    OPEN_CMD := open
  else
    OPEN_CMD := xdg-open
  endif
endif

# Captura todo lo que el usuario ponga tras el target actual
ARGS := $(filter-out $@,$(MAKECMDGOALS))

# Macro: abrir URL cuando el puerto esté listo (NO_OPEN=1 para desactivar)
define OPEN_WHEN_READY
@if [ -z "$$NO_OPEN" ]; then \
  ( \
    PORT=$(1); URL="$(2)"; \
    echo "🔎 Abriendo $${URL} cuando esté listo (export NO_OPEN=1 para desactivar)…"; \
    for i in $$(seq 1 120); do \
      if command -v nc >/dev/null 2>&1 && nc -z 127.0.0.1 $$PORT >/dev/null 2>&1; then break; fi; \
      if command -v lsof >/dev/null 2>&1 && lsof -i :$$PORT -sTCP:LISTEN >/dev/null 2>&1; then break; fi; \
      sleep 0.5; \
    done; \
    $(OPEN_CMD) "$${URL}" >/dev/null 2>&1 || true; \
  ) & \
fi
endef

.PHONY: help test test_ca test_en test-prod deploy clean

help: ## Muestra este ayuda
	@echo "Comandos:"
	@echo "  make test                -> Limpia y levanta dev en ES (abre http://127.0.0.1:4000)"
	@echo "  make test_ca             -> Limpia y levanta dev en CA (abre http://127.0.0.1:4000)"
	@echo "  make test_en             -> Limpia y levanta dev en EN (abre http://127.0.0.1:4000)"
	@echo "  make test-prod           -> Build prod y sirve estático (abre http://127.0.0.1:4000)"
	@echo "  make deploy              -> Exige árbol limpio (sin autocommit)"
	@echo "  make deploy \"tu mensaje\" -> Autocommit con ese mensaje + deploy"

clean:
	@npm run clean

test:
	@npm run clean
	$(call OPEN_WHEN_READY,4000,http://127.0.0.1:4000)
	@npm run dev

test_ca:
	@npm run clean
	$(call OPEN_WHEN_READY,4000,http://127.0.0.1:4000)
	@npm run dev:ca

test_en:
	@npm run clean
	$(call OPEN_WHEN_READY,4000,http://127.0.0.1:4000)
	@npm run dev:en

test-prod:
	@npm run clean
	$(call OPEN_WHEN_READY,4000,http://127.0.0.1:4000)
	@npm run build && @npm run serve:static

# Deploy: si hay ARGS, se concatenan y se pasan como 1 argumento (autocommit)
deploy:
	@set -e; \
	if [ "$(strip $(ARGS))" = "" ]; then \
	  bash scripts/deploy.sh; \
	else \
	  MSG="$(strip $(ARGS))"; \
	  bash scripts/deploy.sh "$$MSG"; \
	fi

# Catch-all para que 'make deploy foo bar' no falle por objetivos extra
%:
	@:
