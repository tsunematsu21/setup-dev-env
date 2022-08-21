go: install/go ## Install latest golang

install:: install/go
uninstall:: uninstall/go
version:: version/go

install/go: common
	echo '[$@] add apt repo...'
	sudo add-apt-repository -y ppa:longsleep/golang-backports > /dev/null

	echo '[$@] update apt...'
	sudo apt-get update > /dev/null

	echo '[$@] install package...'
	sudo apt-get -y install golang-go > /dev/null

uninstall/go:
	echo '[$@] purge package...'
	sudo apt-get -y purge golang-go > /dev/null

version/go:
ifeq ($(shell command -v go),)
	echo [go] not installed
else
	echo [go]
	echo "  go : $$(go version)"
endif
