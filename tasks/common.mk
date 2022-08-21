BASHRC				:=	~/.bashrc
BASHRC_DIR		:=	$(BASHRC).d
SUDOERS_USER	:= /etc/sudoers.d/$(USER)

common: $(SUDOERS_USER) apt $(BASHRC_DIR)

$(SUDOERS_USER):
	@echo '[common] create $(SUDOERS_USER)...'
	@echo '$(USER) ALL=NOPASSWD: ALL' | sudo tee $(SUDOERS_USER)

apt:
	@echo '[common] update packages...'
	@sudo apt-get update > /dev/null

	@echo '[common] upgrade packages...'
	@sudo apt-get -y upgrade > /dev/null

	@echo '[common] autoremove packages...'
	@sudo apt-get -y autoremove > /dev/null

define BASHRC_DIR_INIT
# Include scripts
if [ -d $(BASHRC_DIR) ]; then
  for i in $(BASHRC_DIR)/*.sh; do
    if [ -r $$i ]; then
    . $$i
    fi
  done
  unset i
fi
endef
export BASHRC_DIR_INIT

$(BASHRC_DIR):
	@echo '[common] create $(BASHRC_DIR)...'
	@mkdir -p $(BASHRC_DIR)

	@echo '[common] add settings $(BASHRC) for load $(BASHRC_DIR)...'
	@echo "$${BASHRC_DIR_INIT}" >> $(BASHRC)
