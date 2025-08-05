# Variables
PAGES_DIR := pages
LAYOUTS_DIR := _layouts
LANG_DIR := _i18n
DEFAULT_SECTION := default_section
DEFAULT_FOLDER := make/defaults

new_page:
	@if [ -z "$(name)" ]; then \
		echo "Error: name must be provided."; \
		exit 1; \
	fi

	@echo "Creating new page..."
	@mkdir -p $(PAGES_DIR)
	@echo "---" > $(PAGES_DIR)/$(name).html
	@echo "layout: $(name)" >> $(PAGES_DIR)/$(name).html
	@echo "title: $(name).title" >> $(PAGES_DIR)/$(name).html
	@echo "" >> $(PAGES_DIR)/$(name).html
	@echo "namespace: $(name)" >> $(PAGES_DIR)/$(name).html
	@echo "image_path: assets/images/$(name)/" >> $(PAGES_DIR)/$(name).html
	@echo "var_tokens: assets/css/tokens-home" >> $(PAGES_DIR)/$(name).html
	@echo "" >> $(PAGES_DIR)/$(name).html
	@echo "permalink: $(name)" >> $(PAGES_DIR)/$(name).html
	@echo "---" >> $(PAGES_DIR)/$(name).html
	@echo "Page created at $(PAGES_DIR)/$(name).html"

	@echo "Creating new layout..."
	@cp $(DEFAULT_FOLDER)/default-template.html $(LAYOUTS_DIR)/$(name).html
	@echo "Layout created at $(LAYOUTS_DIR)/$(name).html"

	@echo "Updating language files..."
	@for lang_file in $(LANG_DIR)/*.yml; do \
		lang_file_name=$$(basename $$lang_file); \
		sed "s/{{section_name}}/$(name)/g" $(DEFAULT_FOLDER)/default-$$lang_file_name >> $$lang_file; \
	done
	@echo "Language files updated."
	@echo "New page created successfully."