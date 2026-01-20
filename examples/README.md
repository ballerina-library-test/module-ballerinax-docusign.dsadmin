# Examples

The `docusign.dsadmin` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples), covering use cases like user lifecycle management, automated user onboarding, and compliance export workflows.

1. [User lifecycle management](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/user-lifecycle-management) - Manage the complete lifecycle of users from creation to deactivation in DocuSign organizations.

2. [Automated user onboarding](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/automated-user-onboarding) - Automate the process of onboarding new users to DocuSign with proper configurations and permissions.

3. [Manage user information](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/manage-user-information) - Update and maintain user profile information and settings within DocuSign organizations.

4. [Compliance export workflow](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/compliance-export-workflow) - Export organizational data and user activities for compliance and audit purposes.

5. [Permissions in organizations](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/permissions-in-organizations) - Configure and manage user permissions and access levels across DocuSign organizations.

## Prerequisites

1. Generate DocuSign credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/docusign.dsadmin/latest#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    token = "<Access Token>"
    ```

## Running an Example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```