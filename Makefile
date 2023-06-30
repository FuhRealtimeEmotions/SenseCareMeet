UpdateAndReset:
	@echo "Updating and resetting the repository..."
	@git reset --hard
	@git pull
	@echo "Done."
	@mv server/config/config_ibm.yaml server/config/config.yaml
	@cd server && yarn build
	@cd server && DEBUG=${DEBUG:='*mediasoup* *INFO* *WARN* *ERROR*'} INTERACTIVE=${INTERACTIVE:='true'} yarn start server.js

UpdateAndResetWithApp:
	@echo "Updating and resetting the repository..."
	@git reset --hard
	@git pull
	@echo "Done."
	@mv server/config/config_ibm.yaml server/config/config.yaml
	@cd app && yarn build
	@cd server && yarn build
	@cd server && DEBUG=${DEBUG:='*mediasoup* *INFO* *WARN* *ERROR*'} INTERACTIVE=${INTERACTIVE:='true'} yarn start server.js

StartIBM: 	
	@cp server/config/config_ibm.yaml server/config/config.yaml
	@cd app && yarn build
	@cd server && yarn build
	@cd server && DEBUG=${DEBUG:='*mediasoup* *INFO* *WARN* *ERROR*'} INTERACTIVE=${INTERACTIVE:='true'} yarn start server.js

StartLocally:
	@cp server/config/config_local_docker.yaml server/config/config.yaml
#	docker compose up --build -d
	@cd app && yarn build
	@cd server && yarn build
	@cd server && DEBUG=${DEBUG:='*mediasoup* *INFO* *WARN* *ERROR*'} INTERACTIVE=${INTERACTIVE:='true'} yarn start server.js

FirstSetupLocally:
	@cp server/config/config_local_docker.yaml server/config/config.yaml
#	docker compose up --build
	@cd app && yarn install
	@cd server && yarn install
	@cd app && yarn build
	@cd server && yarn build
	@cd server && DEBUG=${DEBUG:='*mediasoup* *INFO* *WARN* *ERROR*'} INTERACTIVE=${INTERACTIVE:='true'} yarn start server.js

InstallNVM:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	nvm install 14

InstallStunServerDocker:
	docker run -d -p 3478:3478 -p 49152-65535:49152-65535/udp instrumentisto/coturn

InstallRedisDocker:
	docker run --name redis -d -p 6379:6379 redis

InstallRabbitMQManagementDocker:
	docker run -d --hostname my-rabbit --name rabbitmq -p 15672:15672 -p 5672:5672 rabbitmq:3-management

PrepareDocker:	
	@docker compose build --no-cache

prerequisites:
	sudo apt install nodejs
	sudo apt install npm
	curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
	source ~/.bashrc   
	nvm install 14
	npm install --global yarn

	docker compose up --build