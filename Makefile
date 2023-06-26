# Variables
PROJET = project
DOCKER = docker 
DOCKER_COMPOSE = docker-compose
DJANGO_ADMIN = django-admin
EXEC = ${DOCKER} exec -w /var/www/${DOCKER}  www_project

## —— 🔥 App ——
create-app: ## Créer un projet
	$(DOCKER_COMPOSE) run --rm app $(DJANGO_ADMIN) startproject $(PROJET) .

## —— 🐳 Docker ——
build: ## Construire images
	$(MAKE) docker-build
docker-build: ## Construire images
	$(DOCKER_COMPOSE) build

start: ## Démarrer les container / Start app
	$(MAKE) docker-start 
docker-start: 
	$(DOCKER_COMPOSE) up -d

stop: ## Arrêter les containers / Stop app
	$(MAKE) docker-stop
docker-stop: 
	$(DOCKER_COMPOSE) stop
	@$(call RED,"The containers are now stopped.")

stopAll: ## Arrêter tout les containers en cours
	$(DOCKER) stop $$(docker ps -a -q)

deleteContainers: ## Supprimer tout les containers
	$(DOCKER) container prune

deleteImages: ## Supprimer toutes les images
	$(DOCKER) image prune -a

## —— 🛠️  Others ——
chown: ## Chown
	sudo chown -R $$USER ./
	
help: ## Liste des commandes / List of commands
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'