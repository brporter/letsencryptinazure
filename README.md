# Azure Let's Encrypt Cert Retrieval and Renewal
## What is this?
A docker container that glues together three things:

1. Azure CLI
2. acme.sh
3. openssl

Essentially, the container this Dockerfile produces uses the acme.sh ACMEv2 client to retrieve a certificate for a specifeid list of domains, modify Azure DNS with the expected DNS challenges, fetch the certificates, convert them to PKCS12 format, and import them into Azure KeyVault.

## How do I use this?
I made this because I was bored. It's probably not useful.

First, you need an Azure Service Principal with rights to create TXT records for the zones you are going to request certificates for.

Second, you need an Azure KeyVault to import the finished certificate into.

Then, to run from the command line it's a simple matter of:

```
docker run --rm \
   -e DOMAINS=<comma seperated list of domains> \
   -e AZUREDNS_SUBSCRIPTIONID='<Azure Subscription ID>' \ 
   -e AZUREDNS_TENANTID='<Azure Tenant ID>' \
   -e AZUREDNS_APPID='<Service Principal AppID with DNS Contributor or Similar Rights>' \
   -e AZUREDNS_CLIENTSECRET='<Service Prinicpal Password / Client Secret>' \
   -e CERT_PASSWORD='<Password for the Merged PKCS12 Certificate>' 
   -e AZURE_KEYVAULT='<Name of the Destination KeyVault>' 
   -e EMAIL='<Email Address for Certificate>' 
   --net=host
```