# Makefile para gestionar operaciones de Git para usuarios que no están familiarizados con Git

# Variable que guarda el nombre de la rama actual
CURRENT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

# Verifica si hay cambios pendientes en la rama actual
CHANGES := $(shell git status --porcelain)


push: verify_branch commit_changes switch_to_main pull_main install_dependencies switch_back merge_main switch_to_main_again merge_feature push_main return_to_original_branch 
update: verify_branch commit_changes switch_to_main pull_main install_dependencies switch_back merge_main 

verify_branch:

	@if [ "$(CURRENT_BRANCH)" = "main" ] || [ "$(CURRENT_BRANCH)" = "main" ]; then \
		echo "\033[31mError:Estás en la rama $(CURRENT_BRANCH). Por favor, cambia a una rama de características para usar este Makefile\033[0m"; \
		exit 1; \
	fi

commit_changes:
# Verifica si se ha proporcionado un mensaje de commit solo si hay cambios
	@if [ -n "$(CHANGES)" ]; then \
		if [ -z "$(m)" ]; then \
			echo "\033[31mError:El parametro m es obligatorio. Uso: make m=\"Tu mensaje de commit aquí\"\033[0m"; \
			exit 1; \
		fi; \
		git add .; \
		git commit -m "$(m)"; \
	fi

switch_to_main:
	git checkout main

pull_main:
	git pull origin main

switch_back:
	git checkout $(CURRENT_BRANCH)

merge_main:
	git merge main

switch_to_main_again:
	git checkout main

merge_feature:
	git merge $(CURRENT_BRANCH)

push_main:
	git push origin main

return_to_original_branch:
	git checkout $(CURRENT_BRANCH)


.PHONY: push update verify_branch commit_changes switch_to_main pull_main switch_back merge_main switch_to_main_again merge_feature push_main return_to_original_branch install_dependencies
