📝 **Complete Guide to Connect to SharePoint Online with PowerShell**
=====================================================================

1\. **Install PowerShell 7**
----------------------------

1.  **Download PowerShell 7** from the official GitHub repository:

    -   [Download PowerShell 7](https://github.com/PowerShell/PowerShell/releases)
2.  **Install PowerShell 7** using the MSI installer for Windows (x64).

3.  **Verify Installation**:

    Open **PowerShell 7** by searching for `pwsh` in the Start Menu, then check the version:

    ```
    powershell
    $PSVersionTable.PSVersion
    ```

    You should see a version **7.2 or higher**.

* * * *

2\. **Install PnP PowerShell Module**
-------------------------------------

1.  Open **PowerShell 7** (`pwsh`) as an Administrator.

2.  **Install the PnP PowerShell Module**:

    ```powershell
    Install-Module -Name PnP.PowerShell -Force
    ```

3.  **Verify the Installation**:

    ```powershell
    Get-Module -ListAvailable -Name PnP.PowerShell
    ```

* * * *

3\. **Set Execution Policy**
----------------------------

Set the execution policy to allow script execution:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope Process
```

When prompted, type **`Y`** and press **Enter** to confirm.

* * * *

4\. **Register an Azure AD App for PnP PowerShell**
---------------------------------------------------
- As of September 9th, 2024, the default PnP Management Shell app ID for interactive login will no longer be available. To resolve this, you need to register your own Azure AD application and authenticate using it.
1.  Go to the **Azure Portal**: <https://portal.azure.com>.

2.  **Register a New App**:

    -   Navigate to **Azure Active Directory** > **App registrations**.
    -   Click **New registration**.
    -   Enter a **Name** (e.g., "PnP PowerShell App").
    -   Set the **Redirect URI** to `http://localhost`.
    -   Click **Register**.
3.  **Set API Permissions**:

    -   In the app registration, go to **API Permissions**.
    -   Click **Add a permission**.
    -   Select **SharePoint** > **Delegated permissions**.
    -   Add permissions like:
        -   `AllSites.Read`
        -   `AllSites.Write`
        -   `Sites.Manage.All` (if managing sites).
    -   Click **Grant admin consent**.
4.  **Create a Client Secret**:

    -   Go to **Certificates & secrets**.
    -   Click **New client secret**.
    -   Add a description and select an expiration period.
    -   Click **Add** and **copy the secret value** (you'll need it later).

* * * *

5\. **Connect to SharePoint Online Using PnP PowerShell**
---------------------------------------------------------

1.  Open **PowerShell 7**.

2.  **Connect to Your SharePoint Site**:

    ```powershell
    Connect-PnPOnline -Url https://yourtenant.sharepoint.com/sites/yoursite -Interactive
    ```
    -   Replace `yourtenant` with your actual tenant name.
    -   Replace `yoursite` with your site name.
3.  **Verify Connection**:

    You should be prompted for login credentials. Complete the login to establish the connection.

* * * *

6\. **Retrieve SharePoint Lists**
---------------------------------

After connecting, run the following command to list all lists in the site:

```powershell
Get-PnPList | Select-Object Title
```

### Example Output:

```markdown
Title
-----
_catalogs/hubsite
200_Rows - Actual List (3)
200_Rows - Actual List (4)
Account
AdventureWorksCustomer
```

* * * *

7\. **Update PnP PowerShell**
-----------------------------

Keep your PnP PowerShell module up to date:

```powershell
Update-Module -Name PnP.PowerShell
```

* * * *

✅ **Summary of Key Commands**
=============================

1.  **Install PowerShell 7**:
    Download from [GitHub Releases](https://github.com/PowerShell/PowerShell/releases).

2.  **Install PnP PowerShell**:

    ```powershell
    Install-Module -Name PnP.PowerShell -Force
    ```

3.  **Set Execution Policy**:

    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope Process
    ```

4.  **Connect to SharePoint**:

    ```powershell
    Connect-PnPOnline -Url https://yourtenant.sharepoint.com/sites/yoursite -Interactive
    ```

5.  **List All Lists**:

    ```powershell
    Get-PnPList | Select-Object Title
    ```

* * * *

This guide covers everything from setting up your environment to connecting and working with SharePoint Online lists using PowerShell.