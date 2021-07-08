FROM mcr.microsoft.com/azure-cli:latest AS azure-cli

RUN curl https://get.acme.sh | sh -s

WORKDIR /app
COPY run.pl . 

RUN chmod +x run.pl

CMD ["./run.pl"]
