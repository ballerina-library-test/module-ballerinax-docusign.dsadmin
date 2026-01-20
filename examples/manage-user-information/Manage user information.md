# Manage User Information

This example demonstrates how to manage DocuSign organization users by retrieving organization information, creating new users, and fetching user details within an organization.

## Prerequisites

1. **DocuSign Setup**
   > Refer the [DocuSign setup guide](https://central.ballerina.io/ballerinax/docusign.dsadmin/latest#setup-guide) here.

2. For this example, create a `Config.toml` file with your credentials:

```toml
clientId = "<Your Client ID>"
clientSecret = "<Your Client Secret>"
refreshToken = "<Your Refresh Token>"
refreshUrl = "<Your Refresh URL>"
accountId = "<Your Account ID>"
userId = "<Your User ID>"
email = "<Your Email>"
serviceUrl = "<Your Service URL>"
```

## Run the example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```