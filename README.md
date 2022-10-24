
# Terraform Modules Explanation

## Basic understanding of Modules

Prerequisites:

* An AWS account Configure one of the authentication methods described in our AWS Provider Documentation. The examples in this tutorial assume that you are using the shared credentials file method with the default AWS credentials file and default profile.
* AWS CLI 
* TERRAFORM INSTALLED 

Module structure:

Terraform treats any local directory referenced in the source argument of a module block as a module. A typical file structure for a new module is:

├── LICENSE

├── README.md

├── main.tf

├── variables.tf

├── outputs.tf

* Terraform considers a file with extension .tf as a configuration file.

TYPES OF FILE IN TERRAFORM
* variables.tf (which is use to define the input variable type For eg: string,list bool)
* outputs.tf (will contain the output definitions for your module)
* main.tf (will contain the main set of configuration for your module)
* terraform.tfstate.backup (These files contain your Terraform state, and are how Terraform keeps track of the relationship between your configuration and the infrastructure provisioned by it.)
* *.tfvars (used to set values for input variables)

ROOT MODULES:
Root modules consist of main.tf file which is used to define the variables values and call the modules using source address.
Terraform treats any local directory referenced in the source argument of a module block as a module.

## VPC MODULES
 Terraform_modules (Terraform directory in which we could add many modules directory eg: rds_modules)

   ├── vpc_modules 

     ├── main.tf (root_modules)
     ├──modules
        ├──main.tf (child_modules)
        ├── variables.tf (child_modules)
        ├── outputs.tf (child_modules)
     ├── outputs.tf (root_modules)

     ROOT_MODULES:

     This is the module structure of our vpc_module.This con be 
     reused by changing the defined values in root_modules as per requirements
     for eg:

     module "vpc_mod" {
      source = "./modules"
      #vpc cidr range
      vpc_cidr = "10.0.0.0/24"
      .......
     }
      (For eg: We could change the value of cidr_range from 10.0.0.0/24 to 192.0.0.0/24
      as per requirements, Like this we can change values)

      CHILD_MODULES:

      main.tf:
      It contains the main set of configuration for your modules for eg:
       
        resource "aws_vpc" "myvpc" {
        cidr_block       = var.vpc_cidr (var is defined as the input variables)
        ........
        }
       (This is the main.tf file which contains the resource configuration code)
      
      variables.tf:

      variable "vpc_cidr" {
        type = string
        description = "cidr range for vpc"
      }

      (This is the variables.tf file which defines the type of input variables, in 
      this case the type is string there are other types like list,number,bool,map etc..)

      outputs.tf:
      This is the child_module level output file will contain the output definitions for your module
      for eg:
       output "myvpc_id" {
        description = "id of the created vpc"
        value = aws_vpc.myvpc.id
        }
        which provides the output (vpc_id) after execution

    DEFINING OUTPUT IN ROOT_MODULES :
     
     Earlier, WE added several outputs to the outputs.tf in child_modules level, making those values available to your root module configuration
     Add another outputs.tf in outputs.tf file in your root module directory For eg:
     output "myvpc_id" {
     description = "id of the created vpc"
     value       = module.vpc_mod.myvpc_id
     }

TERRAFORM COMMANDS :

terraform init: to initialize the terraform configuration file

terraform validate: to validate the command whether is it valid for execution

terraform plan: to plan an execution 

terraform apply: to apply and execute the infrastructure provisioning

terraform refresh: to refresh the infra if any manual update done outside terraform
