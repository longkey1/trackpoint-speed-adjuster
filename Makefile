.DEFAULT_GOAL := help

define _executable
	@if ! type $(1) &> /dev/null; then \
		echo "not found $(1) command."; \
		exit 1; \
	fi
endef

.PHONY: install
install:  _requires ## setup files
	cp -r ./opt/trackpoint-adjuster /opt/ && chmod +x /opt/trackpoint-adjuster/*.sh
	cp ./etc/udev/rules.d/50-trackpoint-adjuster.rules /etc/udev/rules.d/50-trackpoint-adjuster.rules

.PHONY: uninstall
uninstall: ## delete installed files
	rm -rf /opt/trackpoint-adjuster
	rm -f /etc/udev/rules.d/50-trackpoint-adjuster.rules

.PHONY: _requires
_requires:
	@$(call _executable,"/usr/bin/at")
	@$(call _executable,"/usr/bin/parallel")
	@$(call _executable,"/usr/bin/xinput")



.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
