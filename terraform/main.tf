terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.2"
    }
  }
}

provider "github" {
  owner = "JFenstermacher"
}

locals {
  manifest_files = fileset("${path.module}/files", "**")

  manifests = { for f in local.manifest_files: f => file(f) }
}

output "manifest_files" {
  value = local.manifest_files
}

resource "github_repository_file" "manifest" {
  for_each   = local.manifests

  repository = "testing-github-provider"
  branch     = "argocd"
  file       = each.key
  content    = each.value

  commit_message = "ci: automated commit"
  commit_author  = "terraform-automated"
  commit_email   = ""
}
