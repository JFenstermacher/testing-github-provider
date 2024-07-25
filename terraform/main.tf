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
