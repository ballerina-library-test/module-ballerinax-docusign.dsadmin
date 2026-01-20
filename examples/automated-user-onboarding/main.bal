import ballerina/io;
import ballerinax/docusign.dsadmin;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

public function main() returns error? {
    
    dsadmin:ConnectionConfig config = {
        auth: {
            clientId: clientId,
            clientSecret: clientSecret,
            refreshToken: refreshToken,
            refreshUrl: "https://account.docusign.com/oauth/token"
        }
    };

    dsadmin:Client docusignClient = check new (config);

    io:println("Starting automated user onboarding workflow...\n");

    io:println("Step 1: Retrieving available organizations");
    
    dsadmin:OrganizationsResponse organizationsResponse = check docusignClient->/v2/organizations(mode = "org_admin");
    
    dsadmin:OrganizationResponse[]? orgsArray = organizationsResponse.organizations;
    if orgsArray is () {
        io:println("No organizations found for the authenticated user");
        return;
    }
    
    if orgsArray.length() == 0 {
        io:println("No organizations found for the authenticated user");
        return;
    }
    
    io:println("Found organizations:");
    foreach dsadmin:OrganizationResponse org in orgsArray {
        string orgId = org.id ?: "N/A";
        string orgName = org.name ?: "N/A";
        io:println(string `  - Organization ID: ${orgId}, Name: ${orgName}`);
    }
    
    dsadmin:OrganizationResponse firstOrg = orgsArray[0];
    string selectedOrgId = firstOrg.id ?: "";
    if selectedOrgId == "" {
        io:println("Unable to get organization ID");
        return;
    }
    
    io:println(string `Selected organization ID: ${selectedOrgId}\n`);

    io:println("Step 2: Creating new user accounts with role-based permissions");
    
    string defaultAccountId = firstOrg.default_account_id ?: "";
    
    dsadmin:UpdateUserRequest hrUser = {
        id: "hr_user_001",
        site_id: 1,
        userName: "Jane Smith",
        firstName: "Jane",
        lastName: "Smith",
        email: "jane.smith@company.com",
        defaultAccountId: defaultAccountId
    };
    
    dsadmin:UpdateUserRequest salesUser = {
        id: "sales_user_001", 
        site_id: 1,
        userName: "John Doe",
        firstName: "John", 
        lastName: "Doe",
        email: "john.doe@company.com",
        defaultAccountId: defaultAccountId
    };
    
    dsadmin:UpdateUsersRequest updateRequest = {
        users: [hrUser, salesUser]
    };
    
    io:println("Creating users in the organization...");
    dsadmin:UsersUpdateResponse userUpdateResponse = check docusignClient->/v2/organizations/[selectedOrgId]/users/profiles.post(updateRequest);
    
    boolean successStatus = userUpdateResponse.success ?: false;
    io:println(string `User creation operation success: ${successStatus}`);
    
    dsadmin:UserUpdateResponse[]? usersArray = userUpdateResponse.users;
    if usersArray is dsadmin:UserUpdateResponse[] {
        io:println("User creation results:");
        foreach dsadmin:UserUpdateResponse user in usersArray {
            anydata errorDetailsField = user["errorDetails"];
            if errorDetailsField is () {
                string userEmail = user.email ?: "N/A";
                string userId = user.id ?: "N/A";
                io:println(string `  ✓ Successfully processed user: ${userEmail} (ID: ${userId})`);
            } else {
                string userEmail = user.email ?: "N/A";
                anydata errorDetailsData = user["errorDetails"];
                io:println(string `  ✗ Error processing user ${userEmail}: ${errorDetailsData.toString()}`);
            }
        }
    }
    
    io:println("\nAutomated user onboarding workflow completed!");
    io:println("Next steps would include:");
    io:println("- Assigning specific product permission profiles based on user roles");
    io:println("- Setting up account-level permissions");
    io:println("- Configuring signing and envelope permissions");
    io:println("- Sending welcome emails to new users");
}