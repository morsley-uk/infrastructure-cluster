# RKE Provider

As the Terraform RKE provider is not yet released (v1.0.0-rc3), you will need to download this manually.

https://github.com/rancher/terraform-provider-rke/releases

You will then need to copy it into the '.terraform/plugins/[YOUR OS]' folder.
The 'exe' file will need it's OS component of its name removing.

i.e. terraform-provider-rke_windows-386.exe --> terraform-provider-rke.exe

Running ```terraform init``` should now work.

## Terraform Backend

```
terraform init --backend-config="access_key=" --backend-config="secret_key="
```


