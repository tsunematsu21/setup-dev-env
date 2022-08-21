FNM_DIR			:=	$(HOME)/.fnm
FNM_BASHRC	?=	$(BASHRC_DIR)/fnm.sh

define FNM_BASHRC_CONTENT
export PATH=$(FNM_DIR):$$PATH
eval "$$(fnm env --use-on-cd)"
endef
export FNM_BASHRC_CONTENT

fnm: install/fnm ## Install fnm and latest Node.js

install:: install/fnm
uninstall:: uninstall/fnm
version:: version/fnm

install/fnm:
ifeq ($(wildcard $(FNM_DIR)),)
	echo '[$@] install fnm...'
	curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell &> /dev/null
endif

	echo '[$@] create $(FNM_BASHRC)...'
	echo '$(FNM_BASHRC_CONTENT)' > $(FNM_BASHRC)

	echo '[$@] load $(FNM_BASHRC)...'
	. $(FNM_BASHRC)

	echo '[$@] install latest Node.js...'
	fnm install --lts &> /dev/null

	echo '[$@] enable corepack...'
	corepack enable > /dev/null

uninstall/fnm:
	echo '[$@] remove $(FNM_DIR)...'
	sudo rm -rf $(FNM_DIR)

	echo '[$@] remove $(FNM_BASHRC)...'
	sudo rm -f $(FNM_BASHRC)

version/fnm:
ifeq ($(wildcard $(FNM_DIR)),)
	echo [fnm] not installed
else
	. $(FNM_BASHRC)
	echo [fnm]
	echo "  fnm  : $$(fnm --version)"
	echo "  node : $$(node --version)"
	echo "  yarn : $$(yarn --version)"
endif
