All files in this folder should start with a unique filename prefix. They are designed to be copied into other modules via the following syntax
```
terraform {
  source = "git::..."

  after_hook "copy_global_providers" {
    commands = ["init-from-module"]
    execute  = ["cp", "${get_terragrunt_dir()}/../../../../terraform/modules/_global/_global_providers.tf", "."]
  }

  after_hook "copy_global_variables" {
    commands = ["init-from-module"]
    execute  = ["cp", "${get_terragrunt_dir()}/../../../../terraform/modules/_global/_global_variables.tf", "."]
  }
 ...
```

The relative folder path will need to be modified to the required path. These files will then be copied across when you run a `terragrunt init`. Make sure you exclude these files via a `.gitignore`.