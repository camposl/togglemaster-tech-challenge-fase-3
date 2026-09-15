SHELL       := /usr/bin/env bash
PROJECT     ?= togglemaster
AWS_REGION  ?= us-east-1
TF          ?= terraform
STACK       ?= 10-infra
TFDIR       := terraform/$(STACK)

export PROJECT AWS_REGION

.PHONY: help bootstrap init fmt validate plan apply destroy whoami ci-secrets

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-14s %s\n", $$1, $$2}'

whoami: ## Confere qual identidade AWS esta ativa
	@aws sts get-caller-identity

bootstrap: ## Cria o bucket de state e gera backend.hcl (idempotente)
	@bash scripts/bootstrap-backend.sh

init: ## terraform init com backend parcial
	@cd $(TFDIR) && $(TF) init -backend-config=../../backend.hcl -reconfigure

fmt: ## Formata todo o HCL do repositorio
	@$(TF) fmt -recursive terraform/

validate: ## terraform validate do stack atual
	@cd $(TFDIR) && $(TF) validate

plan: ## terraform plan do stack atual
	@cd $(TFDIR) && $(TF) plan -out=tfplan

apply: ## Aplica o plano salvo
	@cd $(TFDIR) && $(TF) apply tfplan

destroy: ## Destroi o stack atual
	@cd $(TFDIR) && $(TF) destroy

ci-secrets: ## Sincroniza credenciais do Academy com os secrets do GitHub
	@bash scripts/refresh-ci-secrets.sh

kubeconfig: ## Configura o kubectl para o cluster
	@cd $(TFDIR) && $(TF) output -raw kubeconfig_command | bash

scale-down: ## Zera o node group entre sessoes
	@aws eks update-nodegroup-config --cluster-name $(PROJECT)-prod-eks --nodegroup-name $(PROJECT)-prod-eks-default --scaling-config minSize=0,desiredSize=0,maxSize=5

scale-up: ## Restaura o node group
	@aws eks update-nodegroup-config --cluster-name $(PROJECT)-prod-eks --nodegroup-name $(PROJECT)-prod-eks-default --scaling-config minSize=2,desiredSize=3,maxSize=5
