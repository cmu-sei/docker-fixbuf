# source: https://jmkhael.io/makefiles-for-your-dockerfiles/
# Run in parallel via make -j2 see: https://stackoverflow.com/a/9220818

NS = cmusei
export SOFTWARE_NAME = fixbuf

export IMAGE_NAME += $(NS)/$(SOFTWARE_NAME)

export WORK_DIR = .

.PHONY: build build2 build3 test

build: build2

build2:
	docker buildx build --platform linux/amd64,linux/arm64 --build-arg http_proxy --build-arg https_proxy --build-arg no_proxy -t $(IMAGE_NAME):latest -f Dockerfile .
	docker tag $(IMAGE_NAME):latest $(IMAGE_NAME):2

build3:
	docker buildx build --platform linux/amd64,linux/arm64 --build-arg http_proxy --build-arg https_proxy --build-arg no_proxy --build-arg FIXBUF_VERSION=3.0.0.alpha2 -t $(IMAGE_NAME):3 -f Dockerfile .	

test:
	docker rm -f $(SOFTWARE_NAME)
	docker run --name=$(SOFTWARE_NAME) -td $(IMAGE_NAME)
	py.test --hosts='docker://$(SOFTWARE_NAME)'
	docker rm -f $(SOFTWARE_NAME)

default: build
