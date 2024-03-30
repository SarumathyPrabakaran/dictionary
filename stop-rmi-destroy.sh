#!/bin/bash

terraform -chdir="./infrastructure/ecs" destroy -auto-approve

terraform -chdir="./infrastructure/ecr" destroy -auto-approve

terraform -chdir="./infrastructure/iam-role" destroy -auto-approve

terraform -chdir="./infrastructure/security-group" destroy -auto-approve

terraform -chdir="./infrastructure/vpc" destroy -auto-approve
