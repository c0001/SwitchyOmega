.PHONY: check-node-ver
check-node-ver:
	@bash -c 'set -e; \
						v=$$(node --version); \
						v=$${v#v}                                                             ; \
						v=$${v%%.*}                                                           ; \
						[[ $$v =~ ^[1-9][0-9]+$$ ]]                                           ; \
						if [[ ! $$v -eq 16 ]]; then \
							echo "node version 16 is stable for this make , but current is $$v" ; \
							exit 1                                                              ; \
						else \
							echo "ok: node version compatible: $$v"                             ; \
						fi'

.PHONY: check-npm-ver
check-npm-ver:
	@bash -c 'set -e; \
						v=$$(npm --version); \
						v=$${v#v}                                                             ; \
						v=$${v%%.*}                                                           ; \
						[[ $$v =~ ^[1-9]([0-9]+)?$$ ]]                                        ; \
						if [[ ! $$v -eq 2 ]]; then \
							echo "npm version 2 is stable for this make , but current is $$v" ; \
							exit 1                                                              ; \
						else \
							echo "ok: npm version compatible: $$v"                             ; \
						fi'


.PHONY: build-all
build-all: check-node-ver check-npm-ver
	npm run deps
	npm install grunt-cli@1.2.0 bower
	node_modules/.bin/grunt
