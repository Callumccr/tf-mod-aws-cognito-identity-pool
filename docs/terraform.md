## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 >= 2.7.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| allow\_unauthenticated\_identities | (Required) - Whether the identity pool supports unauthenticated logins or not. | `bool` | `false` | no |
| attributes | (Optional) - Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| aws\_account\_id | The AWS account id of the provider being deployed to (e.g. 12345678). Autoloaded from account.tfvars | `string` | `""` | no |
| aws\_assume\_role\_arn | (Optional) - ARN of the IAM role when optionally connecting to AWS via assumed role. Autoloaded from account.tfvars. | `string` | `""` | no |
| aws\_assume\_role\_external\_id | (Optional) - The external ID to use when making the AssumeRole call. | `string` | `""` | no |
| aws\_assume\_role\_session\_name | (Optional) - The session name to use when making the AssumeRole call. | `string` | `""` | no |
| aws\_region | The AWS region (e.g. ap-southeast-2). Autoloaded from region.tfvars. | `string` | `""` | no |
| cognito\_identity\_providers | (Optional) - An array of Amazon Cognito Identity user pools and their client IDs. | <code><pre>list(object({<br>    client_id               = string<br>    provider_name           = string<br>    server_side_token_check = bool<br>  }))<br></pre></code> | <code><pre>[<br>  {<br>    "client_id": "",<br>    "provider_name": "",<br>    "server_side_token_check": false<br>  }<br>]<br></pre></code> | no |
| delimiter | (Optional) - Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| enabled | (Optional) - A Switch that decides whether to create the module. Default is true | `bool` | `true` | no |
| environment | (Optional) - Environment, e.g. 'dev', 'qa', 'staging', 'prod' | `string` | `""` | no |
| identity\_pool\_name | (Optional) - The Cognito Identity Pool name. | `string` | `""` | no |
| name | (Optional) - Solution name, e.g. 'vault', 'consul', 'keycloak', 'k8s', or 'baseline' | `string` | `""` | no |
| namespace | (Optional) - Namespace, which could be your abbreviated product team, e.g. 'rci', 'mi', 'hp', or 'core' | `string` | `""` | no |
| tags | (Optional) - Additional tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| identity\_pool\_arn | The ARNs of the cognito identity pool |
| identity\_pool\_id | The ids of the cognito identity pool |

