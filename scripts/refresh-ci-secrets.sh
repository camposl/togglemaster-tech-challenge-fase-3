#!/usr/bin/env bash
set -euo pipefail

REPO="${REPO:-mathvillao/togglemaster-tech-challenge-fase-3}"
PROFILE="${AWS_PROFILE:-default}"

AKID="$(aws configure get aws_access_key_id --profile "${PROFILE}")"
SAK="$(aws configure get aws_secret_access_key --profile "${PROFILE}")"
TOKEN="$(aws configure get aws_session_token --profile "${PROFILE}")"

if [[ -z "${TOKEN}" ]]; then
  echo "ERRO: aws_session_token vazio. Credencial do Academy sempre tem token." >&2
  exit 1
fi

EXPIRY_CHECK="$(aws sts get-caller-identity --profile "${PROFILE}" --query Arn --output text)"
echo "==> Credencial valida para: ${EXPIRY_CHECK}"

gh secret set AWS_ACCESS_KEY_ID     --repo "${REPO}" --body "${AKID}"
gh secret set AWS_SECRET_ACCESS_KEY --repo "${REPO}" --body "${SAK}"
gh secret set AWS_SESSION_TOKEN     --repo "${REPO}" --body "${TOKEN}"

echo "==> Secrets atualizados em ${REPO}."
echo "==> Janela util: ~4h a partir do inicio da sessao do lab."
