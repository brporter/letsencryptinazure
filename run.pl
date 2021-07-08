#!/usr/bin/perl

use strict;

my $domainList = $ENV{'DOMAINS'};
my $domain = (split /,/, $domainList)[0];
my $certificateName = $domain;
   $certificateName =~ s/\.//gi;

system "/root/.acme.sh/acme.sh -m $ENV{'EMAIL'} --issue --dns dns_azure -d $ENV{'DOMAINS'} --server letsencrypt";
system "openssl pkcs12 -export -out /root/.acme.sh/$domain/certificate.pfx -inkey /root/.acme.sh/$domain/$domain.key -in /root/.acme.sh/$domain/fullchain.cer -password pass:$ENV{'CERT_PASSWORD'}";
system "az login --service-principal -u $ENV{'AZUREDNS_APPID'} -p $ENV{'AZUREDNS_CLIENTSECRET'} --tenant $ENV{'AZUREDNS_TENANTID'}";
system "az keyvault certificate import --file /root/.acme.sh/$domain/certificate.pfx --name $certificateName --vault-name $ENV{'AZURE_KEYVAULT'} --password $ENV{'CERT_PASSWORD'}";

