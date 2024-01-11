module "team-admins" {
  source                  = "./template"
  github_team_name        = "team-admins"
  github_team_description = "Team for the GitHub org administrators"
  github_users            = var.github_users
}
