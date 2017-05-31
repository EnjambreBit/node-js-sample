BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
V = \033[92m
N = \033[0m


all:
	@echo ""
	@echo "Comandos disponibles:"
	@echo ""
	@echo "   ${V}deploy${N}     realiza un deploy sobre dokku"
	@echo "   ${V}test${N}       ejecuta los tests"
	@echo ""

deploy:
	@echo "${V}▷ Estás en el branch ${BRANCH} a punto de realizar un deploy ...${N}"
	@sh confirm.sh && make realizar_deploy
	git push

realizar_deploy:
	@echo "${V}▷ Estás en el branch ${BRANCH}${N}"
ifeq (${BRANCH},master)
	make _deploy_a_master
else
ifeq (${BRANCH},staging)
	make _deploy_a_staging
else
	@echo "${V}▷ Se cancela el deploy, no estás en el branch master ni staging.${N}"
endif
endif


_deploy_a_staging:
	git push staging ${BRANCH}:master

_deploy_a_master:
	git push production ${BRANCH}:master


test:
	ls
