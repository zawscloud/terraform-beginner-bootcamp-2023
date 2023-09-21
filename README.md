# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)


The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

### Considerations for Linux Distribution
This project is built against Ubuntu.
Please consider checking your Linux Distro by using this command: ```cat /etc/os-release```

For additional Linux commands please follow the link below:

[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/
)


### Install the Terraform CLI

As of today, these are the latest documentation to Install the Terraform CLI.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Refactoring into Bash Scripts

We decided to create a bash script to install the Terraform CLI.
This bash script is located here: [./bin/install_terraform_cli.sh](./bin/install_terraform_cli.sh)

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
chmod u+x ./bin/install_terraform_cli.sh
```
[Linux Chmod Command](https://en.wikipedia.org/wiki/Chmod)

### Gitpod Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace
https://www.gitpod.io/docs/configure/workspaces/tasks
