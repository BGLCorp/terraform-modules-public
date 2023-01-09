All files in this folder should start with a unique filename prefix. They are designed to be copied into other modules via the following syntax
```
terraform {
  source = "git::..."

  after_hook "copy_global_data" {
    commands = ["init-from-module"]
    execute  = ["wget", "-qN", "https://raw.githubusercontent.com/BGLCorp/terraform-modules-public/v0.0.5/_global/_regional_data.tf"]
  }

  after_hook "copy_global_providers" {
    commands = ["init-from-module"]
    execute  = ["wget", "-qN", "https://raw.githubusercontent.com/jgournet/terraform-modules-public/master/_global/_global_providers.tf"]
  }

 ...
```

The relative folder path will need to be modified to the required path. These files will then be copied across when you run a `terragrunt init`. Make sure you exclude these files via a `.gitignore`.