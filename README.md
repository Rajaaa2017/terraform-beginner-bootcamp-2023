# Terraform Beginner Bootcamp 2023

## 1-semantic-version :mage:
This project is going to utilize semantic versioning for it's tagging
[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.0`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes


## 3-refactor-terraform-cli

## Install Terraform CLI

### Considerations with Terraform cli changes 
Terraform cli installation instructions have changed due to gpg keyring changes. So referred to the latest documentation for Terraform cli installation
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux distribution
This project is designed for use with Ubuntu. Please ensure that your Linux distribution is compatible and make any necessary adjustments based on your specific requirements.

[How to check OS version in Linux](https://opensource.com/article/18/6/linux-version)

Example of checking OS Version:

$uname -srm

$cat /etc/os-release
```
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into BASH scripts
While addressing the Terraform gpg deprecation issues, we observed that the bash script steps contained a significant amount of code. Consequently, we decided to create a bash script for Terraform CLI installation.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- It will keep the gitpod task file tidy. ([.gitpod.yml](.gitpod.yml))
- It simplifies debugging and allows manual execution when necessary.
- It provides better portability for other projects that require Terraform CLI installation.

### Shebang (sha-bang) considerations

[shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

The shebang `#!/bin/sh` at the beginning of a bash script specifies the program that will interpret the script. For improved portability across various OS distributions, Chat GPT recommends using the following shebang: `#!/usr/bin/env sh`

- This approach ensures compatibility with different operating systems.
- It searches the user's PATH for the bash script executable, enhancing flexibility.

### Executions considerations
When executing a bash script, you can use the `./` shorthand notation to run it, as shown here: `./bin/install_terraform_cli`

However, when using a script in a `.gitpod.yml` file, it's necessary to specify the program that will interpret the script. You can do this with the `source` command, like : `source ./bin/install_terraform_cli`

### Linux permission considerations
[Linux Permissions](https://en.wikipedia.org/wiki/Chmod)

To make our bash script executable, it's necessary to modify the Linux permissions to allow execution in user mode.

```sh
chmod u+x ./bin/install_terraform_cli 
or
chmod 744 ./bin/install_terraform_cli
```

### Gitpod lifecycle (before init command)

We need to exercise caution when using the 'init' command because it won't rerun if we restart an existing workspace.

[Gitpod Lifecycle](https://www.gitpod.io/docs/configure/workspaces/tasks)

### Working with Environment Variables

### env command

We can list out all Environment Variables (Env Vars) using the `env` command

We can filter specific env vars using grep Ex: `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terrminal we unset using `unset HELLO`

We can set an env var temporarily by just running a simple command

```
HELLO='world' ./bin/print_message
```

Within a bash script we can set env var without writing export Ex:

```
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Env Vars

We can print an env var using echo Ex: `echo $HELLO`

### Scoping of Env Vars

When you open new bash terminals in VSCode, they may not inherit environment variables set in other terminal windows. 

If you wish for environment variables to persist across all future bash terminals, you should consider setting them in your bash profile. Ex: `.bash_profile file`

### Persisting Env Vars in Gitpod

To persist environment variables in Gitpod, you can store them in Gitpod Secrets Storage. You can set an environment variable like this: 

```
gp env HELLO='world'

```

This command will ensure that all future workspaces launched will have these environment variables available for all bash terminals opened within those workspaces.

You can also set environment variables in the `.gitpod.yml` file, but it's important to remember that this method should only be used for non-sensitive environment variables.

### AWS CLI Installation

AWS CLI is installed for the project via the bash script `./bin/install_aws_cli`

[AWS CLI Installation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[Environment variables to configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

To verify whether our AWS credentials are configured correctly, you can use the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If successful, you should receive a JSON payload that resembles the following:

```sh
{
    "UserId": "AIDA5FKRAJAPX4J2RAJA5GQO7",
    "Account": "9712345467835",
    "Arn": "arn:aws:iam::9712345467835:user/raja"
}
```

To use the AWS CLI, we'll need to generate AWS CLI credentials from an IAM User.

### Terraform Basics

## Terraform Registry

Terraform sources its providers and modules from the Terraform Registry, located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers**: Providers are interfaces to APIs that enable the creation of resources in Terraform.

- **Modules**: Modules are a way to make Terraform code modular, portable, and shareable.

## Terraform Console

 To see a list of all Terraform commands, simply type `terraform`

 `Terraform Init`: At the beginning of a new Terraform project, you should run terraform init to download the necessary binaries for the Terraform providers that you'll use in the project.

 `Terraform Plan`: Running terraform plan generates a changeset that provides information about the state of your infrastructure and what changes will be made. You can choose to output this changeset, but often it can be ignored.

 `Terraform Apply`: Running terraform apply executes the changeset generated by terraform plan. It typically prompts for confirmation (yes or no). To automatically approve an apply, you can use the --auto-approve flag, like this: `terraform apply --auto-approve`

 `Terraform Destroy`: Terraform destroy is used to destroy resources created by Terraform. You can also use the --auto-approve flag to skip the approval prompt, like this `terraform destroy --auto-approve`

 `Terraform Lock Files`: The `.terraform.lock.hcl` file contains locked versioning information for providers or modules used in the project. This file **should be committed** to your Version Control System (VCS), such as GitHub.

 `Terraform State Files`: The `.terraform.tfstate` file contains information about the current state of your infrastructure. This file **should not be committed** to your VCS because it can contain sensitive data. Losing this file means losing the knowledge of your infrastructure's state. The `.terraform.tfstate.backup` file is the previous state file.

 `Terraform Directory`: The `.terraform` directory contains Terraform provider binaries.






