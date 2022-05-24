
# Hub-and-Spoke Network using DRG

A Hub-and-spoke network (often called star topology) has a central component (the hub) that's connected to multiple networks around it, like a wheel. Implementing this topology in the traditional data center can be costly. But in the Oracle Cloud, there’s no extra cost.

With new features added to the Dynamic Routing Gateway (DRG), the DRG is now capable of having multiple VCNs attached, becoming the central component and adding flexibility to how you design your cloud network

For details of the architecture, see [_Set up a hub-and-spoke network topology using dynamic routing gateway_](https://docs.oracle.com/en/solutions/hub-spoke-network-drg/index.html)

## Architecture Diagram

![](./images/hub-spoke-drg-diagram.png)

## Prerequisites

- Permission to `manage` the following types of resources in your Oracle Cloud Infrastructure tenancy: `vcns`, `internet-gateways`, `route-tables`, `security-lists`, `subnets`, and `instances`.

- Quota to create the following resources: 1 VCNS, 1 subnets, and 1 compute instance.

If you don't have the required permissions and quota, contact your tenancy administrator. See [Policy Reference](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Reference/policyreference.htm), [Service Limits](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm), [Compartment Quotas](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcequotas.htm).

## Deploy Using the Terraform CLI

### Clone the Module
Create a local copy of this repository:

    git clone https://github.com/ZConverter/oracle-auto-zdm.git
    cd oracle-auto-zdm
    ls

### Set Up and Configure Terraform

1. Create a `terraform.tfvars` file, and specify the following variables:

```
# Authentication
tenancy_ocid         = "<tenancy_ocid>"
user_ocid            = "<user_ocid>"
fingerprint          = "<finger_print>"
private_key_path     = "<pem_private_key_path>"
region = "<oci_region>"

# Availablity Domain 
availablity_domain_name = "<availablity_domain_name>"

# Compartment
compartment_ocid = "<compartment_ocid>"

# ssh-key
ssh_public_key = "<ssh_public_key_path>"

````

### Create the Resources
Run the following commands:

    terraform init
    terraform plan
    terraform apply

### Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy the resources:

    terraform destroy
