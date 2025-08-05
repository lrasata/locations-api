# Locations API (AWS Lambda + API Gateway managed with Terraform)

This project provides a secure serverless API for accessing location data, powered by AWS Lambda and 
API Gateway.
Infrastructure is managed using **Terraform**.

### Purpose & Context

The goal is originally to be to deploy [Trip design web app](https://github.com/lrasata/trip-planner-web-app) 
(React + TypeScript web app) in a secure way on S3.
But the issue is, to inject secrets securely in a React + Vite app deployed on S3, secrets must be separated from the frontend and a backend must be used to access them.

> There is no secure way to keep a secret in a public browser app.


This project has been created to provide an API endpoint to call for the frontend without requiring any secrets.

## 🛠️ Stack

- **Runtime**: Node.js (Express-style Lambda)
- **Infrastructure**: AWS Lambda, API Gateway (REST), Terraform
- **Deployment**: Terraform CLI
- **Secrets**: AWS Lambda environment variables
- **Security**: API Gateway integration

## 📁 Project Structure

```
├── lambda/                   # Lambda function code
│   └── index.js              # Express-style handler
├── lambda.tf                 # Lambda function & IAM role
├── api-gateway.tf            # API Gateway resources
├── variables.tf              # Input variables
└── outputs.tf                # Outputs
└── README.md
```

## 🚀 Getting Started

### 1. Prerequisites

- Node.js
- AWS CLI with credentials configured
- Terraform `>=1.3`
- AWS IAM user with permissions to deploy Lambda and API Gateway

### 2. Setup

#### 🧬 Install dependencies

If using any npm modules:

```bash
cd lambda
npm install
```

#### 🔐 Define secret API key

In `lambda/index.js`, the secret (e.g., API key) should be passed via environment variables in Terraform:

```js
Authorization: 'Bearer ${process.env.MY_SECRET_API_KEY}'
```


### 3. Deploy with Terraform

```bash
terraform init
terraform plan
terraform apply
```

After deployment, the API endpoint will be printed as output.

## 📦 API Usage

### GET `/locations?dataType=city&namePrefix=Paris`

Query parameters :
- **dataType**: `city` or `country`
- **namePrefix**: the `string` to look up to perform matching on location name
- **countryCode**: country code

Documentation of [Geo DB API](https://rapidapi.com/wirefreethought/api/geodb-cities) used the AWS Lambda

```bash
curl https://<your-api-id>.execute-api.<region>.amazonaws.com/prod/locations?dataType=city&namePrefix=Paris
```

Response:

```json
{
  "city": "Paris",
  "country": "France",
}
```
