### Terrahome AWS

```tf
module "home_payday" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.payday_public_path
  content_version = var.content_version
}
```

The public directory expects the following:

1.index.html

2.error.html

3.assets

All the top level files in assets will be copied, but not any subdirectories.