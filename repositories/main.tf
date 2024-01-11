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
