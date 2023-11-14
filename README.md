# aws-api-lambda-tutorial

By default this fetches AWS credentials from a environmental profile called "awsprofile". This can be modified in `main.tf`

Create by running `terraform init` and `terraform apply`

Password generation is under `/prod/generate` as apparently terraform isn't allowed to deploy root paths.