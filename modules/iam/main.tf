#IAM Role for lambda
resource "aws_iam_role" "lambda_exec" {
  name_prefix = "${var.function_name}_exec_role-"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = { Service = "lambda.amazonaws.com" },
      Effect   = "Allow"
    }]
  })
}

#lambda policy
resource "aws_iam_policy" "lambda_dynamo_policy" {
  name_prefix = "${var.function_name}-dynamo-policy-"
  description = "Allows lambda to write and read in dynamodb"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:DeleteItem"
        ],
        Resource = var.table_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_dynamo_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_dynamo_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


#IAM Role for amplify
resource "aws_iam_role" "this" {
  name = var.amplify_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "amplify.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Policy for Amplify builds
resource "aws_iam_role_policy_attachment" "amplify_admin_access" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess-Amplify"
}
