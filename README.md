# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)


The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

#### Considerations for Linux Distribution
This project is built against Ubuntu.
Please consider checking your Linux Distro by using this command: ```cat /etc/os-release```

For additional Linux commands please follow the link below:

[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/
)


#### Install the Terraform CLI

As of today, these are the latest documentation to Install the Terraform CLI.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

#### Refactoring into Bash Scripts

We decided to create a bash script to install the Terraform CLI.
This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allow us an easier way to debug and execute manual installation of the Terraform CLI.
- This will allow better portablility for other projects that need to install Terraform CLI.

#### Shebang
A Shebang (pronuced Sha-bang) tells the bash script what program that will interpret the script. eg. `#!/bin/env bash`

[Linux Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Execution Consideration

WHen executing the bash script we can us `./` shorthand notation to execute the bash script

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.
eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash script executable we need to change linux permission for the file to be execuatable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```
[Linux Chmod Command](https://en.wikipedia.org/wiki/Chmod)

### Gitpod Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working with Env Vars

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

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up a new bash terminal in VSCODE it will not be aware of env vars that you have set in another window.

If you want the Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces. 

You can also set env vars in the `gitpod.yml` file but this can only contain non-sensitive env vars

### AWS CLI Installation

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
