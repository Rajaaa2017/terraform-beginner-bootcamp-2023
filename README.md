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