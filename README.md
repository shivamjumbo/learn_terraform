# azure-devops-test-setup

This repository serves two purposes for the pipelines and templates provided in https://github.com/jumbo-supermarkten/ado-pipeline-templates 
- For development teams: it's an example setup of terraform and its deployment using Azure DevOps pipelines
- For enablement team: it's for testing these pipelines and templates

Contents
- `terraform/` contains a very simple terraform setup to get started with in Azure 
- `pipelines/` contains the same example pipelines as provided in https://github.com/jumbo-supermarkten/ado-pipeline-templates, used to test the templates by deploying the terraform resources

## How to use it as an example
- **Context:** This repository was created using `/github` automation, and the corresponding Azure DevOps project was created using `/azure-workloads` automation. It's targeting an existing Azure dedicated workload subscription `JMB-ET-AUT`, as it was specified in the `/azure-workloads`. Everything in this repo works out-of-the-box.
- Check the https://github.com/jumbo-supermarkten/ado-pipeline-templates readme to understand what has been setup.
- **Pipelines:** the `pipelines/` directory contains `high-level/` and `low-level/` directories. They both serve the same purpose, but the latter is more customizable than the former. Therefore, unless you have a specific use-case, use the example pipelines from `high-level/`
- **Terraform:** use this terraform as a quickstart to get going. For local development, specify all of the backend in `main.tf`, except the SAS token. For the SAS token:
  - go to the storage account container, and create a SAS token 
  - store it as `ARM_SAS_TOKEN` environment variable, with value `?[your-generated-sas-token]` (the `?` is needed)