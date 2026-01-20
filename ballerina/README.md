## Overview

[DocuSign](https://www.docusign.com/) is a leading electronic signature and digital transaction management platform that enables organizations to securely send, sign, and manage documents digitally, streamlining business processes and eliminating paper-based workflows.

The `ballerinax/docusign.dsadmin` package offers APIs to connect and interact with [DocuSign Admin API](https://developers.docusign.com/docs/admin-api/) endpoints, specifically based on [DocuSign Admin API v2.1](https://developers.docusign.com/docs/admin-api/reference/).
## Setup guide

To use the DocuSign Admin connector, you must have access to the DocuSign Admin API through a [DocuSign developer account](https://developers.docusign.com/) and obtain an API access token. If you do not have a DocuSign account, you can sign up for one [here](https://www.docusign.com/products/electronic-signature).

### Step 1: Create a DocuSign Account

1. Navigate to the [DocuSign website](https://www.docusign.com/) and sign up for an account or log in if you already have one.

2. Ensure you have a Business Pro or higher plan, as the DocuSign Admin API is restricted to organization administrators on these plans.

### Step 2: Generate an API Access Token

1. Log in to your DocuSign account as an organization administrator.

2. Navigate to Settings in the top navigation bar, then select Apps and Keys from the left sidebar under Integrations.

3. In the Apps and Keys section, scroll down to the My Apps & Keys area and select Add App and Integration Key.

4. Fill in the required information for your application and click Create App.

5. Once created, you can generate access tokens using OAuth 2.0 authentication or use the integration key with JWT authentication.

> **Tip:** You must copy and store this key somewhere safe. It won't be visible again in your account settings for security reasons.
## Quickstart

To use the `DocuSign DS Admin` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/docusign.dsadmin as dsadmin;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and configure the obtained access token:

```toml
token = "<Your_DocuSign_Access_Token>"
```

2. Create a `dsadmin:ConnectionConfig` and initialize the client:

```ballerina
configurable string token = ?;

final dsadmin:Client dsadminClient = check new({
    auth: {
        token
    }
});
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Create a new user

```ballerina
public function main() returns error? {
    dsadmin:NewUserRequest newUser = {
        email: "john.doe@example.com",
        firstName: "John",
        lastName: "Doe",
        userName: "John Doe",
        languageCulture: "en",
        accounts: [
            {
                id: "your-account-id",
                permissionProfile: {
                    id: 1,
                    name: "DocuSign Sender"
                }
            }
        ]
    };

    dsadmin:NewUserResponse response = check dsadminClient->/v2/organizations/[organizationId]/users.post(newUser);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```
## Examples

The `docusign.dsadmin` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples), covering the following use cases:

1. [User lifecycle management](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/user-lifecycle-management) - Demonstrates how to manage the complete lifecycle of users from creation to deactivation.
2. [Automated user onboarding](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/automated-user-onboarding) - Illustrates automating the process of onboarding new users to the DocuSign platform.
3. [Manage user information](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/manage-user-information) - Shows how to retrieve, update, and manage user profile information and settings.
4. [Compliance export workflow](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/compliance-export-workflow) - Demonstrates how to export compliance data and manage regulatory reporting workflows.
5. [Permissions in organizations](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/permissions-in-organizations) - Illustrates managing user permissions and access controls within organizational structures.