# creating aws amplify and hosting app from git-hub

resource "aws_amplify_app" "example" {
  name = var.app_name
  repository = var.git_repo

  access_token = var.github_access_token

  enable_branch_auto_build = true
  enable_branch_auto_deletion = true

  build_spec = templatefile("${path.module}/buildspec.yml.tpl", {
    API_GATEWAY_URL_root = var.API_GATEWAY_URL_root
  })

  environment_variables = {
    API_GATEWAY_URL_root = var.API_GATEWAY_URL_root
    API_GATEWAY_URL_history = var.API_GATEWAY_URL_history
  }
}

resource "aws_amplify_branch" "main" {
  app_id = aws_amplify_app.example.id
  branch_name = "main"
  enable_auto_build = true
  stage = "PRODUCTION"
}
