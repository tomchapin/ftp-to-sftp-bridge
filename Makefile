#!make

.PHONY: all

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

stop:
	docker-compose stop

restart:
	docker-compose restart

shell:
	docker exec -it ftp-to-sftp-bridge /bin/sh

logs:
	docker-compose logs -f

clean:
	docker container stop ftp-to-sftp-bridge || true
	docker container rm ftp-to-sftp-bridge || true
	docker volume rm sshfs_for_user1 || true
	docker volume rm sshfs_for_user2 || true

ensure-correct-ssh-key-permissions:
	chmod 0600 $$(pwd)/.ssh/*
	chmod 0700 $$(pwd)/.ssh

uninstall-sshfs:
	docker plugin disable vieux/sshfs:latest || true
	docker plugin remove vieux/sshfs:latest || true

install-sshfs:
	docker plugin install vieux/sshfs:latest --grant-all-permissions DEBUG=1 sshkey.source=$$(pwd)/.ssh/

full-reset-after-changing-ssh-keys:
	$(MAKE) down && $(MAKE) clean && $(MAKE) uninstall-sshfs && $(MAKE) ensure-correct-ssh-key-permissions && $(MAKE) install-sshfs