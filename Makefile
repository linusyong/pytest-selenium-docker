
all:	venv setup test teardown

venv:
	@[ -d venv ] || { \
		virtualenv -p python3 venv; \
		venv/bin/pip install tox; \
	}

setup:
	$(eval NGINX_CONTAINER_ID := $(shell docker run -it -P -d -v $(shell pwd)/site/:/usr/share/nginx/html/ --rm nginx))
	$(eval NGINX_EXPOSED_PORT := $(shell docker port ${NGINX_CONTAINER_ID} 80 | awk -F: '{print $$2}'))
	$(eval SELENIUM_CONTAINER_ID := $(shell docker run -d -it -p 4444:4444 --rm selenium/standalone-chrome))

test:
	$(eval IP_DEV := $(shell ip route | awk '/default/ { print $$5 }'))
	$(eval IP_ADDRESS := $(shell ip -o -4 addr list ${IP_DEV} | awk -F"[/ ]" '{print $$7}'))
	@. venv/bin/activate; \
	tox -e py3.5 -- --base-url http://${IP_ADDRESS}:${NGINX_EXPOSED_PORT}/

teardown:
	@docker stop ${NGINX_CONTAINER_ID} >/dev/null
	@docker stop ${SELENIUM_CONTAINER_ID} >/dev/null

clean:
	rm -rf venv *log .cache .tox junit*xml
	find . -name __pycache__ -print0 | xargs -0 rm -rf
