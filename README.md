
# Ballerina docusign.dsadmin connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-docusign.dsadmin.svg)](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/docusign.dsadmin.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%docusign.dsadmin)

## Overview

[DocuSign](https://www.docusign.com/) is a leading electronic signature and digital transaction management platform that enables organizations to securely sign, send, and manage documents digitally, streamlining business processes and eliminating paper-based workflows.

The `ballerinax/docusign.dsadmin` package offers APIs to connect and interact with [DocuSign Admin API](https://developers.docusign.com/docs/admin-api/) endpoints, specifically based on [DocuSign Admin API v2.1](https://developers.docusign.com/docs/admin-api/reference/).
## Setup guide

To use the DocuSign Admin connector, you must have access to the DocuSign Admin API through a [DocuSign developer account](https://developers.docusign.com/) and obtain an API access token. If you do not have a DocuSign account, you can sign up for one [here](https://www.docusign.com/products/admin).

### Step 1: Create a DocuSign Account

1. Navigate to the [DocuSign website](https://www.docusign.com/) and sign up for an account or log in if you already have one.

2. Ensure you have a Business Pro or Enterprise plan, as the DocuSign Admin API is restricted to organization administrators on these plans.

### Step 2: Generate an API Access Token

1. Log in to your DocuSign account.

2. Navigate to Settings in the top navigation menu, then select Apps and Keys from the left sidebar under Integrations.

3. In the Apps and Keys section, locate your application or create a new one, then select Actions and choose Edit.

4. In the Authentication section, generate a new access token by clicking Generate Token.

> **Tip:** You must copy and store this key somewhere safe. It won't be visible again in your account settings for security reasons.
## Quickstart

To use the `docusign.dsadmin` connector in your Ballerina application, update the `.bal` file as follows:

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
                    id: 2,
                    name: "DocuSign Sender"
                },
                companyName: "Example Corp",
                jobTitle: "Manager"
            }
        ]
    };

    dsadmin:NewUserResponse response = check dsadminClient->/v2/organizations/["your-organization-id"]/users.post(newUser);
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
4. [Compliance export workflow](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/compliance-export-workflow) - Demonstrates implementing workflows for exporting compliance-related data and reports.
5. [Permissions in organizations](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/permissions-in-organizations) - Illustrates managing user permissions and roles within organizational structures.
## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

    > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

    > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

    ```bash
    ./gradlew clean build
    ```

2. To run the tests:

    ```bash
    ./gradlew clean test
    ```

3. To build the without the tests:

    ```bash
    ./gradlew clean build -x test
    ```

4. To run tests against different environments:

    ```bash
    ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
    ```

5. To debug the package with a remote debugger:

    ```bash
    ./gradlew clean build -Pdebug=<port>
    ```

6. To debug with the Ballerina language:

    ```bash
    ./gradlew clean build -PbalJavaDebug=<port>
    ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToCentral=true
    ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).


## Useful links

* For more information go to the [`docusign.dsadmin` package](https://central.ballerina.io/ballerinax/docusign.dsadmin/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
