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

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Environment Variables - those you would set in your bash terminal eg. AWS Credentials
- Terraform Variables - those that you would normally set in your tfvars file.

We can set Terraform Cloud variables to be sensitive so they are not visible in the UI.

### Loading Terraform Input Variables 

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file. eg. `terraform apply -var="user_uuid=my-user_id"`

### var-file flag
We can create a file with file name ending in either `.tfvars` or `.tfvars.json` and then specify that file on the command line with `-var-file`. eg. `terraform apply -var-file="testing.tfvars"`

### terraform.tfvars
This is the default file to load in terravor variables in blunk

### auto.tfvars
Terraform also automatically loads a number of variable definitions files if they are present. eg. `.auto.tfvars` or `.auto.tfvars.json`

### order of terraform variables

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:
1. Environment variables.
2. The `terraform.tfvars` file, if present.
3. The `terraform.tfvars.json` file, if present.
4. Any `*.auto.tfvars` or `*.auto.tfvars.json` files, processed in lexical order of their filenames.
5. Any `-var` and `-var-file` options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)
