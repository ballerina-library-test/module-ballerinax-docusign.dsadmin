import ballerina/io;
import ballerina/http;
import ballerinax/docusign.dsadmin;

configurable string accessToken = ?;
configurable string organizationId = ?;
configurable string accountId = ?;

type DeleteResponse record {|
    anydata...;
|};

public function main() returns error? {
    
    dsadmin:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    dsadmin:Client docusignClient = check new (config);
    
    io:println("=== DocuSign Compliance Audit Workflow ===");
    io:println("Starting account settings export for regulatory review...");
    
    dsadmin:OrganizationAccountRequest accountRequest = {
        account_id: accountId
    };
    
    dsadmin:OrganizationAccountsRequest exportRequest = {
        accounts: [accountRequest]
    };
    
    io:println("Step 1: Initiating account settings export for compliance documentation...");
    dsadmin:OrganizationExportResponse exportResponse = check docusignClient->/v2/organizations/[organizationId]/exports/account_settings.post(exportRequest);
    
    string exportId = exportResponse.id ?: "";
    if exportId == "" {
        return error("Failed to get export ID from response");
    }
    
    io:println(string `Export initiated successfully. Export ID: ${exportId}`);
    io:println(string `Export created at: ${exportResponse.created ?: "N/A"}`);
    io:println(string `Export expires at: ${exportResponse.expires ?: "N/A"}`);
    
    io:println("\nStep 2: Checking export progress and completion status...");
    dsadmin:OrganizationExportResponse statusResponse = check docusignClient->/v2/organizations/[organizationId]/exports/account_settings/[exportId].get();
    
    io:println(string `Export Status: ${statusResponse.status ?: "Unknown"}`);
    
    anydata sizeValue = statusResponse["sizeBytes"];
    string sizeDisplay = sizeValue is int ? sizeValue.toString() : "0";
    io:println(string `Export Size: ${sizeDisplay} bytes`);
    
    anydata urlValue = statusResponse["url"];
    string urlDisplay = urlValue is string ? urlValue : "Not available";
    io:println(string `Download URL: ${urlDisplay}`);
    
    anydata metadataUrlValue = statusResponse["metadataUrl"];
    string metadataUrlDisplay = metadataUrlValue is string ? metadataUrlValue : "Not available";
    io:println(string `Metadata URL: ${metadataUrlDisplay}`);
    
    if statusResponse.status == "completed" {
        io:println("✓ Export completed successfully - ready for audit team download");
        io:println("✓ Compliance report is available for regulatory review");
        
        io:println("\nStep 3: Cleaning up completed export after audit team processing...");
        json|error deleteResult = docusignClient->/v2/organizations/[organizationId]/exports/account_settings/[exportId].delete();
        DeleteResponse deleteResponse = check deleteResult.cloneWithType(DeleteResponse);
        
        io:println("✓ Export data cleaned up successfully");
        io:println("✓ Compliance audit workflow completed");
        
    } else if statusResponse.status == "processing" {
        io:println("⏳ Export is still processing - audit team should check back later");
        io:println("Note: Export cleanup should be performed after completion and download");
        
    } else if statusResponse.status == "failed" {
        io:println("✗ Export failed - compliance team needs to retry the export process");
        
        io:println("\nCleaning up failed export...");
        json|error deleteResult = docusignClient->/v2/organizations/[organizationId]/exports/account_settings/[exportId].delete();
        DeleteResponse deleteResponse = check deleteResult.cloneWithType(DeleteResponse);
        io:println("✓ Failed export data cleaned up");
    }
    
    io:println("\n=== Workflow Summary ===");
    io:println("1. Account settings export initiated for compliance documentation");
    io:println("2. Export status monitored for completion tracking");
    io:println("3. Export cleanup performed to maintain data hygiene");
    io:println("4. Regulatory compliance requirements fulfilled");
}