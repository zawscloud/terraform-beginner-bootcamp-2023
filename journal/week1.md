# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags
[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locally delete a tag
```sh
git tag -d <tag_name>
```

Remotely delete a tag
```sh
git push --delete origin tagname
```

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


## Dealing with Conifguration Drift

## what happens if we lose our state file?

IF you lose your statefile, you most likely have to tear down all your cloud infra manually.

You can use terraform import but it won't work for all cloud resources. You need to check the terraform providers documentation for which resources support import

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.example`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone deletes or modifies cloud resource manually through Clickops, we can run `terraform plan` to attempt to put our infrastructure back into the expected state fixing a configuration drift.

### Fix using terraform referesh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

IT is recommended to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables
We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "../modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
 ```

### Modules Sources

Using the source we can import the module from various places. eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "../modules/terrahouse_aws"
}
 ```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Consideration when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It might produce outdated documents or examples that does not work with the current provider.

## Working with Files in Terraform

### File exist function

This is a built-in terraform function to check the existance of a file. eg:

```tf
    condition     = fileexists(var.error_html_filepath)
```
[Fileexist](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

[filemd5 function](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root of the project.

[Special Path Variables](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

#### Using the `path.root` as a source for your `index.html` code.

[S3 Object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object)

```tf
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"

  
  etag = filemd5("${path.root}/public/index.html")
}
```

[etag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object.html#etag) - (Optional) Triggers updates when the value changes with in an `index.html` or `error.html` file.

## Terraform Locals

Locals allows us to define local variables.
IT can be very useful when we need to transform data into another format and have it referenced as a variable.
```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources

This allows us to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with Json

We use the jsonencode to create the json policy inline in our code.
```tf
> jsonencode({"hello"="world"})
{"hello":"world"}

```
[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the lifecycle of Resources

[Meta Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.


[Using terraform_data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Provisioners

Provisioners allow you to execute commands on compute instances. eg. AWs CLI Command.

They are not recommended for use by Hishicorp because Configuration Management tools such as Ansible are a better fit, but the functionality exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute a command on the machine running the terraform command. eg plan apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}

```
### Remote-exec

This will execute commands on a maching which you target. you will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```

## For Each Expressions

For each expressions allows us to enumerate over complex data types

```tf
[for s in var.list : upper(s)]
```

This is mostly useful when you are creating multiples of a cloud resource and you want to reduce repetitiveness in your terraform code.

[For Each Expressions](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
