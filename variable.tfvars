project_name       = "mwa-validate-project"
environment        = "dev"
region             = "ap-south-1"
source_repo_name   = "terraform-sample-repo"
source_repo_branch = "main"
create_new_repo    = true
repo_approvers_arn = "arn:aws:sts::175383983227:assumed-role/CodeCommitReview/*" #Update ARN (IAM Role/User/Group) of Approval Members
create_new_role    = true
#codepipeline_iam_role_name = <Role name> - Use this to specify the role name to be used by codepipeline if the create_new_role flag is set to false.
validation_stage_input = [
  { name = "validate", category = "Test", owner = "AWS", provider = "CodeBuild", input_artifacts = "SourceOutput", output_artifacts = "ValidateOutput" },
  { name = "plan", category = "Test", owner = "AWS", provider = "CodeBuild", input_artifacts = "SourceOutput", output_artifacts = "PlanOutput" }
]
deploy_stage_input = [
  { name = "apply", category = "Build", owner = "AWS", provider = "CodeBuild", input_artifacts = "SourceOutput", output_artifacts = "ApplyOutput" }
]
build_projects = ["validate", "plan", "apply"]
