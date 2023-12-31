# Terraform Beginner Bootcamp 2023 - Week 0


- [Semantic Versioning](#semantic-versioning)
- [Considerations for Linux Distribution](#considerations-for-linux-distribution)
- [Install the Terraform CLI](#install-the-terraform-cli)
- [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
- [Shebang](#shebang)
- [Execution Consideration](#execution-consideration)
- [Linux Permissions Considerations](#linux-permissions-considerations)
- [Gitpod Lifecycle Before Init Command](#gitpod-lifecycle-before-init-command)
- [Working with Env Vars](#working-with-env-vars)
  * [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
  * [Printing Vars](#printing-vars)
  * [Scoping of Env Vars](#scoping-of-env-vars)
  * [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [AWS CLI Installation](#aws-cli-installation)
  * [Generate AWS CLI Credentials](#generate-aws-cli-credentials)
- [Terraform Basics](#terraform-basics)
  * [Terraform Console](#terraform-console)
  * [Terraform Commands](#terraform-commands)
  * [Terraform Files](#terraform-files)
- [Issues with Terraform Cloud Login and Gitpod Workspaces](#issues-with-terraform-cloud-login-and-gitpod-workspaces)
  * [Issues with Terraform Cloud Login and Gitpod Workspace Continue](#issues-with-terraform-cloud-login-and-gitpod-workspace-continue)



## Semantic Versioning

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)


The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Considerations for Linux Distribution
This project is built against Ubuntu.
Please consider checking your Linux Distro by using this command: ```cat /etc/os-release```

For additional Linux commands please follow the link below:

[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/
)


## Install the Terraform CLI

As of today, these are the latest documentation to Install the Terraform CLI.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Refactoring into Bash Scripts

We decided to create a bash script to install the Terraform CLI.
This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allow us an easier way to debug and execute manual installation of the Terraform CLI.
- This will allow better portablility for other projects that need to install Terraform CLI.

## Shebang
A Shebang (pronuced Sha-bang) tells the bash script what program that will interpret the script. eg. `#!/bin/env bash`

[Linux Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

## Execution Consideration

WHen executing the bash script we can us `./` shorthand notation to execute the bash script

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.
eg. `source ./bin/install_terraform_cli`

## Linux Permissions Considerations

In order to make our bash script executable we need to change linux permission for the file to be execuatable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```
[Linux Chmod Command](https://en.wikipedia.org/wiki/Chmod)

## Gitpod Lifecycle Before Init Command

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

## Working with Env Vars

We can list out all Environment variables (Env Vars) using the `env` command.

We can filter specific env vars using grep. eg. `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal we can set env var using `export HELLO='world'`

In the terminal we can unset env var using `unset HELLO`

We can set an env var temporily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without writing export. eg:

```sh

HELLO='world'

echo $HELLO
```

### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

### Scoping of Env Vars

When you open up a new bash terminal in VSCODE it will not be aware of env vars that you have set in another window.

If you want the Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`

### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces. 

You can also set env vars in the `gitpod.yml` file but this can only contain non-sensitive env vars

## AWS CLI Installation

AWS CLI is install for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started (Install AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If it is successful, you should see a json payload return that looks like this:

```json
"UserId": "AKIAIOSFODNN7EXAMPLE",
"Account": "123456789012",
"Arn": "arn:aws:iam::123456789012:user/tfbootcamp"
```

### Generate AWS CLI Credentials 

We'll need to generate AWS CLI credetials from IAM User in order to use the AWS CLI.

Here are the recommended ways when working with AWS CLI credentials: [Authentication and access credentials (Recommended)](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-authentication.html)

But for the purpose of this Bootcamp we are keeping it simple (non-recommended): 

[Authenticate with IAM user credentials
(Not-Recommended)](https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html)

## Terraform Basics



- **Terraform** provisions, updates, and destroys infrastructure resources such as physical machines, VMs, network switches, containers, and more. Terraform sources their providers and modules from the Terraform registry which is located at [registry.terraform.io](https://registry.terraform.io/).
The `.terraform` directory contains binaries of terraform providers.

- **Terraform Registry** makes it easy to use any provider or module. To use a provider or module from this registry, just add it to your configuration; when you run `terraform init`, Terraform will automatically download everything it needs.

- **Providers** are the plugins that Terraform uses to manage those resources. Every supported service or infrastructure platform has a provider that defines which resources are available and performs API calls to manage those resources..

- **Modules** are reusable Terraform configurations that can be called and configured by other configurations. Most modules manage a few closely related resources from a single provider. It also makes your code portable and shareable. 

### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform` in our console.

### Terraform Commands

`terraform init` this command is ran at the start of a new project. It downloads all the necessary binaries from the terraform provider to begin the project. Here you will find the list of all the latest Terraform providers: [Latest Terraform Providers](https://registry.terraform.io/browse/providers)

`terraform plan` this command will generate a changeset, about the state of our infrastructure and what will be changed.

`terraform apply` this command will run a plan and pass the changeset to be executed by terraform. Apply should prompt for yes or no.

To automaticately approve a terraform apply command you can use this command `terraform apply --auto-approve`

`terraform destroy` this command will destroy resources. **Use caution when using it.** 

### Terraform Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File **should be commited** to your Version Control System (VSC). eg. Github, Gitlab

`.terraform.tfstate` contains information about the current state of your infrastructure. 
This file **should not be commited** to your VCS.

This file can contain sensitive data.

If you lose this file, you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.
This file **should not be commited** to your VCS.

## Issues with Terraform Cloud Login and Gitpod Workspaces

When attempting to run `terraform login` it will launch bash in a wiswig view to generate a token. However it does not work as expected in Gitpod VsCode in the browswer.

The workaround is manually generate a token in Terraform Cloud.

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Paste the code in the prompt in the Gitpod VsCode in the browser when asked. You will see a message similar to this:

```
Generate a token using your browser, and copy-paste it into this prompt.

Terraform will store the token in plain text in the following file
for use by subsequent commands:
    /home/gitpod/.terraform.d/credentials.tfrc.json

Token for app.terraform.io:
  Enter a value: 
```

### Issues with Terraform Cloud Login and Gitpod Workspace Continue

When attempting to run `terraform login` it will launch bash in wiswig view to generate a token. However it does not work expected in Gitpod VsCode in the browser.

The workaround is manuall generate a token in Terraform Cloud

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "$TERRAFORM_CLOUD_TOKEN"
    }
  }
}
```

We have automated the workaround with the following bash script. eg [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)
