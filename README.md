# org-infra

## Terraform state

Terraform states are stored in a backend remotely in an AWS S3 bucket. This bucket must be a non-public one, encrypted and have versioning enabled to prevent data loss.

Feel free to edit the file located at `backend.tf`. That one contains the configuration where you would be able to configure where you desire to store the remote state. Hopefully, a <a href="https://developer.hashicorp.com/terraform/language/settings/backends/local">public list of official backends</a> has been published for choosing the one that fits better our needs.

## Configuration

In case our organization does not fit the configuration we should update that value in the section: `main.tf > provider > github > owner`

**Managing teams** it's an easy task. The file is located at `teams/main.tf` and is the one that would contain a module per each team that has been added. The provided example `team-admins`.

The other file you would need to modify for sure is `repositories/main.tf`. That contains a module for each repository managed by our Github provider. The full list of parameters to be configured for each repository can be found at `repositories/templates/variables.tf`. Reviewing this file is crucial after <a href="https://github.com/onebeyond/org-infra?tab=readme-ov-file#importing-a-repository">importing an already existing repository</a> since the parameters would need to be adjusted to avoid any different configuration if that's not our intention.

## Requirements

You need to have Terraform >= 1.6 installed on your machine. You can download it from [here](https://www.terraform.io/downloads.html).

It's strongly recommended to use <a href="https://github.com/tfutils/tfenv">tfenv</a> for running the required **Terraform** version. By having created the file `.terraform-version` this tool would set up the required runtime version immediately.

## Testing locally

You can test the Terraform code locally by running the following commands (you need a valid GitHub token):

```bash
terraform init
terraform plan
```

## Importing a repository

For importing an already existent repository we would need to define a module for it first. That one must be created at `repositories/main.tf` with the desired name.

In our case, we are trying to import a repository named `org-infra`, so the first step is to create the module for importing the existing resources onto the new state module.

```tcl
module "org-infra" {
  source = "./templates"

  github_repository = {
    name       = "org-infra"
    visibility = "public"
  }

  github_teams_repository = [{
    team_id    = var.teams-name.team-admins
    permission = "admin"
  }]

  github_repository_topics = ["github"]
}
```

```bash
terraform import module.repositories.module.org-infra.github_repository.repo org-infra
terraform import module.repositories.module.org-infra.github_branch_protection.main org-infra:master
```
