# User Lifecycle Management

This example demonstrates how to manage DocuSign user lifecycles by exporting current user lists, performing bulk user updates, and downloading verification results using the DocuSign Admin API.

## Prerequisites

1. **DocuSign Setup**
   > Refer the [DocuSign setup guide](https://central.ballerina.io/ballerinax/docusign.dsadmin/latest#setup-guide) here.

2. For this example, create a `Config.toml` file with your credentials:

```toml
clientId = "<Your Client ID>"
clientSecret = "<Your Client Secret>"
refreshToken = "<Your Refresh Token>"
organizationId = "<Your Organization ID>"
```

## Run the example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```