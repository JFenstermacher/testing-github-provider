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
  dir            = "${path.module}/files"
  manifest_files = fileset(local.dir, "**")

  manifests = { for f in local.manifest_files: f => file("${local.dir}/${f}") }
}

resource "github_repository_file" "manifest" {
  for_each   = local.manifests

  repository = "testing-github-provider"
  branch     = "argocd"
  file       = each.key
  content    = "kubernetes/${each.value}"

  commit_message = "ci: automated commit"
  commit_author  = "terraform-automated"
  commit_email   = ""
}
