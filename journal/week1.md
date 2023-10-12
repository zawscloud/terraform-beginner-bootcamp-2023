# Terraform Beginner Bootcamp 2023 - Week 1


## Root Module Structure

Our root module strucutre is as follows:
 
```
PROJECT_ROOT/
|
├── main.tf - everything else 
├── providers.tf - defines required providers and their configurations 
├── variables.tf - stores the structure of input variables
├── terraform.tfvars - the data of variables we want to load into our Terraform project
├── outputs.tf - stores our outputs
└── README.md - required for root modules

```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
