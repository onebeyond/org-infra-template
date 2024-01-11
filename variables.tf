variable "github_token" {
  type        = string
  description = "Github token"
}

variable "github_organization" {
  type        = string
  description = "Github organization"
  default     = "one-beyond"

}

variable "github_users" {
  type = list(object({
    username          = string
    organization_role = string
    teams = list(object({
      team      = string
      team_role = string
    }))
  }))
  default = [{
    username          = "admin"
    organization_role = "admin"
    teams = [
      {
        team      = "team-admins"
        team_role = "admin"
      },
    ]
  }]
}
