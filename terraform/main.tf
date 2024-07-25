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
  repository = "testing-github-provider"

  dir            = "${path.module}/files"
  manifest_files = fileset(local.dir, "**")

  manifests = { for f in local.manifest_files: f => file("${local.dir}/${f}") }
}

data "github_repository" "this" {
  full_name = local.repository
}
