# DocuSign Organization Permissions Management

This example demonstrates how to manage permissions and users within DocuSign organizations. The script retrieves organization information, creates a new user, fetches user details, and displays permission profiles and groups for the specified account.

## Prerequisites

1. **DocuSign Setup**
   > Refer to the [DocuSign setup guide](https://central.ballerina.io/ballerinax/docusign.dsadmin/latest#setup-guide) to obtain the necessary credentials and configure your DocuSign developer account.

2. **Configuration**

   Create a `Config.toml` file with your DocuSign credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   refreshUrl = "<Your Refresh URL>"
   accountId = "<Your Account ID>"
   email = "<Your Email>"
   serviceUrl = "<Your Service URL>"
   ```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing organizations, user creation results, user information, permission profiles, and groups.

```bash
bal run
```

The script will:
1. Retrieve all organizations associated with your account
2. Create a new user in the first organization
3. Fetch user information for the specified email
4. Display permission profiles for the account
5. Show available groups in the organization