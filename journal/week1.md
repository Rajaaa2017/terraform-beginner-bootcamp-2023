# Terraform Beginner Bootcamp 2023 - Week1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf               # Contains the main configuration for the project.
│
├── variables.tf          # Defines the structure of input variables.
│
├── terraform.tfvars      # Contains the data for the input variables used in the project.
│
├── providers.tf          # Defines and configures the required providers.
│
├── outputs.tf            # Contains the configuration for the project outputs.
│
└── README.md             # Essential documentation for the root module.
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In Terraform, we can work with two types of variables:

- Environment Variables: These are variables typically set in your shell environment, such as AWS credentials.
- Terraform Variables: These variables are typically set in your `.tfvars` files.

Terraform Cloud allows us to set sensitive variables for added security.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values)

### var flag

The `-var` flag in Terraform can be used to set an input variable or override a variable defined in a `.tfvars` file.

Ex:

```
terraform plan -var user_id="user_uuid"
```

### var-file flag

The `-var-file` flag in Terraform is used for specifying a variable file that contains values for input variables. This allows you to keep your variable values separate from your main configuration files, making it easier to manage and maintain configurations for different environments.

Ex:

```
terraform apply -var-file=terraform.tfvars
```
In this example, the `-var-file` flag is used to specify the `terraform.tfvars` file, which contains variable values that will be used during the Terraform execution.

### terraform.tfvars

The `terraform.tfvars` file is the default for specifying Terraform variables. It allows you to define essential configuration variables, keeping your code clean and separate from sensitive or environment-specific data.

### auto.tfvars
The auto.tfvars file in Terraform Cloud is an automatic variable configuration file. It allows you to specify variable values directly, simplifying the configuration process without requiring `command-line flags` or a separate `.tfvars` file. When using Terraform Cloud, variables defined in `auto.tfvars` are automatically loaded and take precedence.

Order of Variable Loading in Terraform Cloud:

`auto.tfvars`: Variables in this file are automatically loaded first when using Terraform Cloud.

`terraform.tfvars`: If certain variables are not in `auto.tfvars`, Terraform Cloud checks the `terraform.tfvars` file for additional variable values.


### Order of Precedence for Terraform Variables

Terraform follows a specific order of precedence when determining the values of variables:

1. **Command-Line Flags**: Variables provided via command-line flags, such as `-var` or `-var-file`, take the highest precedence. They can override any other variable values.

2. **Environment Variables**: Terraform allows you to set variables using environment variables. These environment variables take precedence over other sources if defined.

3. **auto.tfvars**: Variables defined in the `auto.tfvars` file automatically take precedence when using Terraform.

4. **terraform.tfvars**: If certain variables are not found in the `auto.tfvars` file, Terraform checks the `terraform.tfvars` file for additional variable values.

5. **Variable Defaults**: If no values are provided from the above sources, Terraform uses default values defined within the configuration.

Variables provided via command-line flags have the highest priority and can override any other source of variable values. The order follows from 1 to 5, with each source taking precedence over the ones listed.

:triangular_flag_on_post: Understanding this order of precedence is essential for effective variable management in Terraform deployments.


## Dealing With Configuration Drift

## What happens if you lose your Terraform state file?

If you lose your Terraform state file, it can be a complex and potentially problematic situation. In most cases:

**1.Manual Cleanup**: You will likely need to manually tear down or manage your cloud infrastructure resources that were managed by Terraform. This process can be time-consuming and error-prone, especially for complex setups.

**2.Partial Use of terraform import**: Terraform provides the terraform import command, which allows you to import existing resources into your Terraform state. However, it's important to note that this functionality is not available for all cloud resources. You'll need to refer to the specific Terraform provider's documentation to determine which resources support the import operation.


## Fix Missing Resources with Terraform Import

```
terraform import aws_s3_bucket.bucket bucket-name
```

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)


# Fix Manual Configuration

If someone modifies or deletes cloud resources manually through ClickOps, Terraform can help bring your infrastructure back to the expected state by fixing configuration drift.

## Detecting Configuration Drift

1. Run `terraform plan` to compare the defined infrastructure state in your Terraform configuration with the actual state of your cloud resources.

2. Review the plan to see the differences between your defined state and the actual state.

## Fixing Configuration Drift

1. Review the plan generated by `terraform plan` to understand the proposed changes.

2. If the plan aligns with your intentions, apply it using the `terraform apply` command.

## What if the terraform plan output does not match with your expectations ?  

:exploding_head: Take backup and work with the team if you are not sure.


## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

Placing modules in a `modules` directory is a recommended practice for local module development. It enhances project organization and clearly signifies that the directory contains reusable Terraform modules. You're free to choose other names if preferred.

### Passing Input Variables

We can pass input variables to our module, and the module must declare these Terraform variables in its own `variables.tf` file.

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```
### Modules Sources

Using the source attribute, you can import Terraform modules from various locations.

Ex:
1.Locally (in your own project directory)
2.GitHub repositories (by specifying the GitHub URL).
3.The Terraform Registry (by specifying the module's namespace and name)

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```
[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

When leveraging ChatGPT to write Terraform code, it's important to bear in mind that LLMs (large language models), such as ChatGPT, might not have access to the most current Terraform documentation and updates. 

Consequently, the generated code may contain outdated examples, potentially impacting Terraform providers, which could be deprecated.

## Working with Files in Terraform

### File exists function

This is a built in terraform function to check the existance of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

[File exists function](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

[Filemd5 Example](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

Special Path Variables in Terraform:

**path.module**: This variable provides the path to the current module. It's useful when you need to reference files or resources within the current module.

**path.root**: This variable gives you the path to the root module. It's particularly handy when you need to access files or resources at the project's root level.

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references)


## Fixing Tags

[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locally delete a tag

```sh
git tag -d <tag_name>
```

Remotely delete tag

```sh
git push --delete origin tagname
```

Checkout the commit that you want to retag. Retrieve the commit SHA from your Github history.

```sh
git checkout <SHA> #replace your SHA ID from the git repo of your commit that you want to retag/correct the tag
git tag M.M.P #replace the tag ID of your choice
git push --tags
git checkout main
```

## Terraform Locals

Locals in Terraform allow you to define local variables, which are particularly useful for transforming data into another format and for referencing variables within your configurations.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources

Terraform data sources enable you to fetch information from cloud resources without the need to import them directly. They provide a way to reference and use data from existing cloud resources within your Terraform configuration.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

When working with JSON in Terraform, you can use the jsonencode function to generate JSON policies directly within your HCL (HashiCorp Configuration Language) code.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

