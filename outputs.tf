# -----------------------------------------------------------------------------
# Outputs: TF-MOD-AWS-COGNITO-IDENTITY-POOL
# -----------------------------------------------------------------------------

output "aws_cognito_identity_pool_id" {
  description = "The ids of the cognito identity pool"
  value       = aws_cognito_identity_pool.default.0.id
}

output "aws_cognito_identity_pool_arn" {
  description = "The ARNs of the cognito identity pool"
  value       = aws_cognito_identity_pool.default.0.arn
}
