# Locations API (AWS Lambda + API Gateway managed with Terraform)

This project provides a secure serverless API for accessing location data, powered by AWS Lambda and 
API Gateway.
Infrastructure is managed using **Terraform**.

<img src="./docs/diagram.png" alt="location-api-diagram">

### Purpose & Context

The original goal is to be able to deploy [Trip design web app](https://github.com/lrasata/trip-planner-web-app) 
(React + TypeScript web app) in a secure way on S3 + CloudFront. This web application is using [Geo DB API](https://rapidapi.com/wirefreethought/api/geodb-cities)
to fetch data related to cities and countries. And to do so, it must provide a secret `API_KEY` in the header of an authenticated request.

But the challenge is, to inject secrets securely in a React + Vite app, secrets must be separated from 
the frontend and a backend must be used to access them. **There is no secure way to keep a secret in a public browser app.**

> ✅ This project has been created to provide an API endpoint to call for the frontend without requiring any secrets.

## Stack

- **Runtime**: Node.js (Express-style Lambda)
- **Infrastructure**: AWS Lambda, API Gateway (REST), Terraform
- **Deployment**: Terraform CLI
- **Secrets**: AWS Lambda environment variables
- **Security**: API Gateway integration

## Project Structure

```
├── lambda/                   # Lambda function code
│   └── handler.js              
├── lambda.tf                 
├── api-gateway.tf            
├── variables.tf              
└── outputs.tf                
└── README.md
```

## Getting Started

### 1. Prerequisites

- Node.js
- AWS CLI with credentials configured
- Terraform `>=1.3`
- ⚠️ AWS IAM user with permissions to deploy Lambda and API Gateway

### 2. Setup

#### Install dependencies

If using any npm modules:

```bash
cd lambda
npm install
```

#### Define Env variables and secret API key

**Local development**

In `lambda/hadnler.js`, the secret (e.g., API key) should be passed via environment variables in Terraform:

```js
Authorization: 'Bearer ${process.env.GEO_DB_RAPID_API_KEY}'
```

List of env variables :
````text
API_CITIES_GEO_DB_URL=
API_COUNTRIES_GEO_DB_URL=
GEO_DB_RAPID_API_HOST=
GEO_DB_RAPID_API_KEY=
````

**For deployed env on AWS**

Secrets has to be defined in AWS Secrets Manager inside : `prod/trip-design-app/secrets` as configure in Terraform file.

Environment variables has to be defined in `terraform.tfvars`


### 3. Deploy with Terraform

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

After deployment, the API endpoint will be printed as output.

## API Usage

### GET `/locations?dataType=city&namePrefix=Paris`

Query parameters :
- **dataType**: `city` or `country`
- **namePrefix**: the `string` to look up to perform matching on location name
- **countryCode**: country code

```bash
curl https://<your-api-id>.execute-api.<region>.amazonaws.com/prod/locations?dataType=city&namePrefix=Paris
```

