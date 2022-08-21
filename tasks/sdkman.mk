SDKMAN_DIR					:=	$(HOME)/.sdkman
SDKMAN_INIT					:=	$(SDKMAN_DIR)/bin/sdkman-init.sh
SDKMAN_BASHRC				?=	$(BASHRC_DIR)/sdkman.sh
SDKMAN_BASHRC_LINE	:=	[[ -s "$(SDKMAN_INIT)" ]] && source "$(SDKMAN_INIT)"

sdkman: install/sdkman ## Install sdkman and latest SDKs(Java, Kotlin, Gradle)

install:: install/sdkman install/sdkman/java install/sdkman/kotlin install/sdkman/gradle
uninstall:: uninstall/sdkman
version:: version/sdkman

install/sdkman: common
ifeq ($(wildcard $(SDKMAN_DIR)),)
	@echo '[$@] install sdkman...'
	@sudo apt-get -qqy install zip unzip > /dev/null
	@curl -s "https://get.sdkman.io?rcupdate=false" | bash &> /dev/null
endif

	@echo '[$@] create $(SDKMAN_BASHRC)...'
	@echo '$(SDKMAN_BASHRC_LINE)' > $(SDKMAN_BASHRC)

install/sdkman/java: install/sdkman
	@echo '[$@] install latest Java using sdkman...'
	@. $(SDKMAN_INIT)
	@sdk install java &> /dev/null

install/sdkman/kotlin: install/sdkman
	@echo '[$@] install latest Kotlin using sdkman...'
	@. $(SDKMAN_INIT)
	@sdk install kotlin &> /dev/null

install/sdkman/gradle: install/sdkman
	@echo '[$@] install latest Gradle using sdkman...'
	@. $(SDKMAN_INIT)
	@sdk install gradle &> /dev/null

uninstall/sdkman:
	@echo '[$@] remove $(SDKMAN_DIR)...'
	@sudo rm -rf $(SDKMAN_DIR)

	@echo '[$@] remove $(SDKMAN_BASHRC)...'
	@sudo rm -f $(SDKMAN_BASHRC)

version/sdkman:
ifeq ($(wildcard $(SDKMAN_INIT)),)
	@echo [sdkman] not installed
else
	@. $(SDKMAN_INIT)
	@echo [sdkman]
	@echo "  sdkman : $$(cat ~/.sdkman/var/version)"
	@echo "  java   : $$(command -v java &> /dev/null && java --version | head -1 || echo not installed)"
	@echo "  kotlin : $$(command -v kotlin &> /dev/null && kotlin -version || echo not installed)"
	@echo "  gradle : $$(command -v gradle &> /dev/null && gradle -v | grep Gradle || echo not installed)"
endif
