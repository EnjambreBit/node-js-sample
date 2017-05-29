BRANCH = $(shell git rev-parse --abbrev-ref HEAD)

deploy:
	@echo "Estás en el branch ${BRANCH} a punto de realizar un deploy ..."
	@sh confirm.sh && make realizar_deploy

realizar_deploy:
	@echo "Estás en el branch ${BRANCH}"
ifeq (${BRANCH},master)
	git push production ${BRANCH}:master
else
ifeq (${BRANCH},staging)
	git push staging ${BRANCH}:master
else
	@echo "Se cancela el deploy, no estás en el branch master ni staging."
endif
endif
