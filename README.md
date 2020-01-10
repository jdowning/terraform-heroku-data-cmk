# Usage

This terraform script will create an AWS KMS Customer Master Key to be used to
encrypt data managed by Heroku Data.

```
git clone https://github.com/jdowning/terraform-heroku-data-cmk
cd terraform-heroku-data-cmk
terraform init
terraform apply \
  -var="account_id=your_aws_account_id" \
  -var="heroku_account_id=heroku_data_aws_account_id"
```
