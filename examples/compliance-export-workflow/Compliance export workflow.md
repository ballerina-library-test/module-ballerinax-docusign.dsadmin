# Compliance Export Workflow

This example demonstrates how to automate DocuSign compliance audit workflows by exporting account settings for regulatory review, monitoring the export progress, and performing cleanup operations to maintain data hygiene.

## Prerequisites

1. **DocuSign Admin Setup**
   > Refer the [DocuSign Admin setup guide](https://central.ballerina.io/ballerinax/docusign.dsadmin/latest#setup-guide) here.

2. For this example, create a `Config.toml` file with your credentials:

```toml
accessToken = "<Your Access Token>"
organizationId = "<Your Organization ID>"
accountId = "<Your Account ID>"
```

## Run the example

Execute the following command to run the example. The script will print its progress to the console.

```shell
bal run
```

The workflow will:
1. Initiate an account settings export for compliance documentation
2. Check the export progress and completion status
3. Clean up the export data after processing
4. Display a comprehensive workflow summary for audit purposes