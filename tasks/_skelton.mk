# short name of install task
_skelton: install/_skelton

# add each task
install:: install/_skelton
uninstall:: uninstall/_skelton
version:: version/_skelton

# install task
install/_skelton:
### your install process is here ###

# uninstall task
uninstall/_skelton:
### your uninstall process is here ###

# version task
version/_skelton:
### your version process is here ###
