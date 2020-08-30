# Aws login

## Begin with

aws config sso

## Login in the account, this updates the ~/.aws/config

aws sso login --profile <profile>

## Update the kubeconfig for the clusters

aws eks update-kubeconfig --name <cluster-name> --profile <profile>
