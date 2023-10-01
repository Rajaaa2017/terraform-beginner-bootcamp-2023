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
