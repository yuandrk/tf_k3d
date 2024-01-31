variable "GITHUB_OWNER" {
  description = "GitHub repository owner"
  default     = "yuandrk"
  type        = string
}

variable "FLUX_GITHUB_REPO" {
  description = "GitHub repository name"
  default     = "sbot-flux-config"
  type        = string
}

variable "GITHUB_TOKEN" {
  sensitive = true
  type      = string
}