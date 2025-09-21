variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "environment" {
  description = "The environment for the deployment (e.g., dev, staging, prod)"
  type        = string
  default     = "staging"
}

variable "API_CITIES_GEO_DB_URL" {
  description = "The URL for the Cities GeoDB API"
  type        = string
}

variable "API_COUNTRIES_GEO_DB_URL" {
  description = "The URL for the Countries GeoDB API"
  type        = string
}

variable "GEO_DB_RAPID_API_HOST" {
  description = "The host for the GeoDB Rapid API"
  type        = string
}

variable "api_locations_domain_name" {
  description = "The domain name for the API locations"
  type        = string
  default     = "api-locations.epic-trip-planner.com"
}

variable "route_53_zone_id" {
  description = "The Hosted Zone ID"
  type        = string
}

variable "backend_certificate_arn" {
  description = "The ARN of the ACM certificate for the ALB HTTPS listener and API Gateway"
  type        = string
}

variable "sns_topic_alerts_arn" {
  description = "ARN of SNS topic alerts"
  type        = string
}
