# Azure DevOps CICD pipeline for .NET application

# Prerequisites Checklist

Azure Account (portal.azure.com)
Azure DevOps Account (dev.azure.com)
.NET Application Code in Repository
Basic Git Knowledge

# Step 1: Create Resource group 
Create Resource Group ->
In Azure portal, click search bar at top ->
Type "Resource groups" and select it ->
Click "+ Create" button ->
Fill in details:
Subscription: Your subscription
Resource group: rg-myapp-production
Region: UAE North
Click "Review + create"
Click "Create"

# Step 2: Create Azure App Service plan

In Azure portal search bar, type "App Service plans"
Click "+ Create"
Fill in details:
Subscription: Your subscription
Resource group: rg-myapp-production (select from dropdown)
Name: asp-myapp-production
Operating System: Linux
Region: UAE North
Pricing tier: Click "Change size"
Select B1 Basic tier
Click "Apply"
Click "Review + create"
Click "Create"

# Step 3: Create Web App

In Azure portal search bar, type "App Services"
Click "+ Create"
Fill in details:
Subscription: Your subscription
Resource group: rg-myapp-production
Name: app-myapp-production (must be unique globally)
Publish: Code
Runtime stack: .NET 6
Operating System: Linux
Region: UAE North
App Service Plan: asp-myapp-production
Click "Review + create"
Click "Create"


# Step 4:  Setup Azure DevOps Project

Open new browser tab → Go to https://dev.azure.com
Sign in with your Microsoft account
If no organization:
Click "Create new organization"
Choose unique name (e.g., mycompany-devops)
Click "Continue"
Create new project:
Project name: MyApp-CICD
Visibility: Private
Version control: Git
Work item process: Agile
Click "Create"

# Step 5: Upload code to azure repo

In your Azure DevOps project, click "Repos" in left sidebar
Click "Initialize" if empty repository
Push Existing Code
cd your-dotnet-project
git init
git add .
git commit -m "Initial commit"
git remote add origin https://dev.azure.com/your-organization/MyApp-CICD/_git/MyApp-CICD
git push -u origin main

# Step 6: Create Azure Service Connection

In your Azure DevOps project, click "Project Settings" (bottom left corner)
In left sidebar, click "Service connections" under Pipelines section
Click "New service connection" button
Select "Azure Resource Manager"
Click "Next"
Authentication method: Select "Service principal (automatic)"
Fill in details:
Subscription: Select your Azure subscription from dropdown
Resource group: Leave as "All resource groups"
Service connection name: azure-myapp-connection
Click "Save"

# Step 7: Verify Service Connection

Back in Service connections list, find your connection
Click the three dots (...) next to it
Click "Manage Service Principal"
Verify it shows "Connected" status

# Step 8: Create CI/CD Pipeline

Create Pipeline YAML File
In your Azure DevOps project, click "Repos"
Click "+" button next to root folder
Create new file named azure-pipelines.yml
Add the cicd-deployment.yaml file.
Click "Commit" to save the file

# Step 9: Create the Pipeline

In Azure DevOps, click "Pipelines" in left sidebar
Click "New pipeline" button
Select "Azure Repos Git"
Select your repository: MyApp-CICD
Select "Existing Azure Pipelines YAML file"
Select the path: /azure-pipelines.yml
Click "Continue"
Review the pipeline and click "Run"


# Step 10: Monitor Pipeline Execution

Go to Azure DevOps → Pipelines
Click on your pipeline "MyApp-CICD"
Watch the real-time execution:
Build stage should show green checkmarks
Deploy stage should start automatically
Wait for completion (5-10 minutes)

# Step 11: Verify Deployment

Open Azure Portal → App Services
Click on your app: app-myapp-production
Click "Overview" in left sidebar
Copy the URL (e.g., https://app-myapp-production.azurewebsites.net)
Open new browser tab and paste the URL
You should see: "website or information from Azure App Service - CI/CD Working!"


# the end.
