FROM node:16-slim

# Install dependencies
RUN apt-get update -y \
    && apt-get install -y curl zip unzip gnupg software-properties-common git

# Install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm awscliv2.zip \
    && rm -r aws

# Install terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    && apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt-get update && apt-get install terraform

# Clean
RUN apt-get autoclean \ 
    && apt-get clean \
    && apt-get auto-remove