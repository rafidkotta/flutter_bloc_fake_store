clean:
	flutter clean

pub_get:
	flutter pub get

build_web: pub_get
	@echo [i] Building web app ...
	flutter build web --release --no-tree-shake-icons
	@echo [✔] Built web app successfully

deploy_web:
	@echo [i] Copying files...
	cp -a build/web/. release/web/
	@echo [✔] Copied files successfully
#	cd /release/web/ || exit
#	@echo [i] Deploying to firebase...
#	firebase deploy --only hosting:beta
#	@echo [✔] Deployed to firebase successfully