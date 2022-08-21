RUST_DIR					:=	$(HOME)/.cargo
RUST_BASHRC				?=	$(BASHRC_DIR)/rust.sh
RUST_BASHRC_LINE	:=	source "$$HOME/.cargo/env"

rust: install/rust ## Install latest rust with rustup

install:: install/rust
uninstall:: uninstall/rust
version:: version/rust

install/rust: common
ifeq ($(wildcard $(RUST_DIR)),)
	echo '[$@] install rust with rustup...'
	curl https://sh.rustup.rs -sSf | sh -s -- -q -y --no-modify-path > /dev/null
endif

	echo '[$@] create $(RUST_BASHRC)...'
	echo '$(RUST_BASHRC_LINE)' > $(RUST_BASHRC)

uninstall/rust:
	echo '[$@] uninstall with rustup...'
	rustup self uninstall -y > /dev/null

version/rust:
ifeq ($(shell command -v rustup),)
	echo [rust] not installed
else
	echo [rust]
	echo "  rustup : $$(rustup --version 2> /dev/null | head -1)"
	echo "  rustc  : $$(rustc --version)"
	echo "  cargo  : $$(cargo --version)"
endif
