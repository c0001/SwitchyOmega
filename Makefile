.PHONY: clean
clean:
	@bash -c "set -e; if [ -d .git ]                                                ; \
		then echo 'In-git-mode'                                                       ; \
			git reset --hard HEAD                                                       ; \
			git clean -xfd .                                                            ; \
		else \
			echo 'No method to clean in non-git-mode'                                   ; \
			exit 1                                                                      ; \
		fi"

.PHONY: sha
sha:
	cd omega-target-chromium-extension/build                                      && \
	sh -c 'if	test -f ../sha256sum.log.tmp; then rm ../sha256sum.log.tmp; fi'     && \
	find -type f -exec sha256sum -b '{}' \; >> ../sha256sum.log.tmp               && \
	sh -c 'if test -f sha256sum.log; then exit 1; fi'                             && \
	mv ../sha256sum.log.tmp ./sha256sum.log

.PHONY: build-all
build-all: clean
	make -C omega-build build-all

.PHONY: release
release: build-all sha
	rm -rf dist
	mkdir  dist
	mv omega-target-chromium-extension/build dist/
	cd dist/build                                                               && \
	sh -c 'zip -r ../SwitchyOmega_$(cat ../../.release-version).zip *' && cd .. && \
	rm -rf build                                                                && \
	sh -c 'sha256sum -b *.zip > sha256sum.log'
