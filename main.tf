resource "aws_cognito_identity_pool" "default" {
  count                            = var.enabled == true ? 1 : 0
  identity_pool_name               = module.label.id
  allow_unauthenticated_identities = var.allow_unauthenticated_identities

  dynamic "cognito_identity_providers" {
    for_each = length(var.cognito_identity_providers) > 0 ? [] : var.cognito_identity_providers
    iterator = provider
    content {
      client_id               = provider.client_id.value
      provider_name           = provider.provider_name.value
      server_side_token_check = provider.server_side_token_check.value
    }
  }
}

resource "aws_iam_role" "authenticated" {
  name               = "${module.role_label.id}${var.delimiter}authenticated"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.default.0.id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "authenticated" {
  name   = "${module.role_label.id}${var.delimiter}authenticated${var.delimiter}policy"
  role   = aws_iam_role.authenticated.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "mobileanalytics:PutEvents",
        "cognito-sync:*",
        "cognito-identity:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF

}

resource "aws_iam_role" "unauthenticated" {
  name               = "${module.role_label.id}${var.delimiter}unauthenticated"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.default.0.id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "unauthenticated"
        }
      }
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "unauthenticated" {
  name = "${module.role_label.id}${var.delimiter}unauthenticated${var.delimiter}policy"
  role = aws_iam_role.unauthenticated.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "mobileanalytics:PutEvents",
        "cognito-sync:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_cognito_identity_pool_roles_attachment" "main" {
  identity_pool_id = aws_cognito_identity_pool.default.0.id

  roles = {
    "authenticated"   = aws_iam_role.authenticated.arn
    "unauthenticated" = aws_iam_role.unauthenticated.arn
  }
}
