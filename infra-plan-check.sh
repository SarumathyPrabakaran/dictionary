#!/bin/bash

terraform -chdir="./infrastructure/ecs" plan 

terraform -chdir="./infrastructure/ecr" plan 

terraform -chdir="./infrastructure/iam-role" plan 

terraform -chdir="./infrastructure/security-group" plan 

terraform -chdir="./infrastructure/vpc" plan 
