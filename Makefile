SHELL := $(shell which bash)

.ONESHELL:
.SILENT:

help: ## Display usage (default task)
	echo Usage: make [task] ...
	echo Tasks:
	awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install:: ## Run all install tasks
	echo '[$@] start'
uninstall:: ## Run all uninstall tasks
	echo '[$@] start'
version:: ## Display all installed versions

include tasks/*.mk

install::
	echo '[$@] done'
	echo 'please reload shell: exec $$SHELL -l'
uninstall::
	echo '[$@] done'
	echo 'please reload shell: exec $$SHELL -l'

# Create new task
tasks/%.mk:
	echo '[$@] create new task file'
	sed -e 's/_skelton/$(basename $(notdir $@))/' tasks/_skelton.mk > $@
