# dev.mk
# Rules related to development tasks, such as starting the server.

install: |
	npm install
	bundle install
	npx rollup -p @rollup/plugin-node-resolve npm-imports.js -o bundle.js
# Npx ho demana material-design, no sé si està ben fet -> https://github.com/material-components/material-web/blob/main/docs/quick-start.md#rollup-quick-start

build:
    # Build _site folder
	bundle exec jekyll build
start:
    # Build _site folder and start local server
	bundle exec jekyll serve