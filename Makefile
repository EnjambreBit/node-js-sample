BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
V = \033[92m
N = \033[0m


all:
	@echo ""
	@echo "Comandos disponibles:"
	@echo ""
	@echo "   ${V}deploy${N}     realiza un deploy sobre dokku"
	@echo ""

deploy:
	@echo "${V}▷ Estás en el branch ${BRANCH} a punto de realizar un deploy ...${N}"
	@sh confirm.sh && make realizar_deploy

realizar_deploy:
	@echo "${V}▷ Estás en el branch ${BRANCH}${N}"
ifeq (${BRANCH},master)
	git push
	git push production ${BRANCH}:master
else
ifeq (${BRANCH},staging)
	git push
	git push staging ${BRANCH}:master
else
	@echo "${V}▷ Se cancela el deploy, no estás en el branch master ni staging.${N}"
endif
endif
