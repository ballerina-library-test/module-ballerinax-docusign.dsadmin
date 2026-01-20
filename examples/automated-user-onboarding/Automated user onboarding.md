# Automated User Onboarding

This example demonstrates how to automate user onboarding workflows using DocuSign's Admin API. The script retrieves available organizations, creates new user accounts with role-based permissions, and provides a foundation for comprehensive user management automation.

## Prerequisites

1. **DocuSign Setup**
   > Refer the [DocuSign setup guide](https://central.ballerina.io/ballerinax/docusign.dsadmin/latest#setup-guide) here.

2. For this example, create a `Config.toml` file with your credentials:

```toml
clientId = "<Your Client ID>"
clientSecret = "<Your Client Secret>"
refreshToken = "<Your Refresh Token>"
```

## Run the example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```