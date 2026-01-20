import ballerina/io;
import ballerina/regex;
import ballerinax/docusign.dsadmin;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string organizationId = ?;

public function main() returns error? {
    
    dsadmin:ConnectionConfig connectionConfig = {
        auth: {
            clientId: clientId,
            clientSecret: clientSecret,
            refreshToken: refreshToken,
            refreshUrl: "https://account.docusign.com/oauth/token"
        }
    };
    
    dsadmin:Client docusignClient = check new (connectionConfig, serviceUrl = "https://api.docusign.com");
    
    io:println("=== DocuSign User Lifecycle Management Workflow ===");
    
    // Step 1: Export current user list to analyze user distribution
    io:println("\n1. Exporting current user list for analysis...");
    
    dsadmin:OrganizationExportRequest exportRequest = {
        'type: "organization_memberships_export"
    };
    
    dsadmin:OrganizationExportResponse exportResponse = check docusignClient->/v2/organizations/[organizationId]/exports/user_list.post(exportRequest);
    
    io:println("Export initiated successfully:");
    io:println("Export ID: ", exportResponse.id ?: "N/A");
    io:println("Status: ", exportResponse.status ?: "N/A");
    io:println("Created: ", exportResponse.created ?: "N/A");
    string resultsUri = exportResponse["results_uri"] is string ? <string>exportResponse["results_uri"] : "N/A";
    io:println("Results URL: ", resultsUri);
    
    // Step 2: Create bulk user update operation based on analysis
    io:println("\n2. Creating bulk user update operation...");
    
    // Sample CSV content for bulk user updates
    string csvContent = "user_id,email,first_name,last_name,user_status,permission_profile_name\n" +
                       "12345678-1234-1234-1234-123456789012,john.doe@example.com,John,Doe,active,DocuSign Sender\n" +
                       "87654321-4321-4321-4321-210987654321,jane.smith@example.com,Jane,Smith,active,Account Administrator";
    
    byte[] csvBytes = csvContent.toBytes();
    
    dsadmin:Bulk_users_update_body updateRequest = {
        "file.csv": {
            fileContent: csvBytes,
            fileName: "bulk_user_updates.csv"
        }
    };
    
    dsadmin:OrganizationImportResponse importResponse = check docusignClient->/v2/organizations/[organizationId]/imports/bulk_users/update.post(updateRequest);
    
    io:println("Bulk user update initiated successfully:");
    io:println("Import ID: ", importResponse.id ?: "N/A");
    io:println("Type: ", importResponse.'type ?: "N/A");
    io:println("Status: ", importResponse.status ?: "N/A");
    io:println("Created: ", importResponse.created ?: "N/A");
    int errorCount = importResponse["errorCount"] is int ? <int>importResponse["errorCount"] : 0;
    int warningCount = importResponse["warningCount"] is int ? <int>importResponse["warningCount"] : 0;
    io:println("Error Count: ", errorCount);
    io:println("Warning Count: ", warningCount);
    
    // Display error rollups if any
    anydata userLevelErrorRollups = importResponse["userLevelErrorRollups"];
    if userLevelErrorRollups is dsadmin:OrganizationImportResponseErrorRollup[] {
        io:println("\nError Summary:");
        foreach var errorRollup in userLevelErrorRollups {
            string errorType = errorRollup["errorType"] is string ? <string>errorRollup["errorType"] : "Unknown";
            int count = errorRollup.count ?: 0;
            io:println("- ", errorType, ": ", count, " occurrences");
        }
    }
    
    // Display warning rollups if any
    anydata userLevelWarningRollups = importResponse["userLevelWarningRollups"];
    if userLevelWarningRollups is dsadmin:OrganizationImportResponseWarningRollup[] {
        io:println("\nWarning Summary:");
        foreach var warningRollup in userLevelWarningRollups {
            string warningType = warningRollup["warningType"] is string ? <string>warningRollup["warningType"] : "Unknown";
            int count = warningRollup.count ?: 0;
            io:println("- ", warningType, ": ", count, " occurrences");
        }
    }
    
    // Step 3: Download import results to verify changes
    io:println("\n3. Downloading import results for verification...");
    
    string importId = importResponse.id ?: "";
    if importId != "" {
        string|error resultsResponse = docusignClient->/v2/organizations/[organizationId]/imports/bulk_users/[importId]/results_csv.get();
        
        if resultsResponse is string {
            io:println("Import results downloaded successfully:");
            io:println("Results CSV Content Preview:");
            io:println("---");
            
            // Display first few lines of the CSV for verification
            string[] lines = regex:split(resultsResponse, "\n");
            int linesToShow = lines.length() < 10 ? lines.length() : 10;
            
            int i = 0;
            while i < linesToShow {
                io:println(lines[i]);
                i += 1;
            }
            
            if lines.length() > 10 {
                io:println("... (", lines.length() - 10, " more lines)");
            }
            io:println("---");
            
        } else {
            io:println("Error downloading results: ", resultsResponse.message());
        }
    } else {
        io:println("No import ID available to download results");
    }
    
    io:println("\n=== User Lifecycle Management Workflow Complete ===");
    io:println("Summary:");
    io:println("- User export initiated for analysis");
    io:println("- Bulk user updates processed with ", errorCount, " errors and ", warningCount, " warnings");
    io:println("- Results downloaded and verified");
}