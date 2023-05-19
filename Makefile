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


Start: 	
	@cp server/config/config_ibm.yaml server/config/config.yaml
	@cd app && yarn build
	@cd server && yarn build
	@cd server && DEBUG=${DEBUG:='*mediasoup* *INFO* *WARN* *ERROR*'} INTERACTIVE=${INTERACTIVE:='true'} yarn start server.js

FirstBuildAfterPull:
	@cd app && yarn install
	@cd server && yarn install

InstallNVM:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	nvm install 14