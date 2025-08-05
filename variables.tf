variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "API_CITIES_GEO_DB_URL" {
  type = string
}

variable "API_COUNTRIES_GEO_DB_URL" {
  type = string
}

variable "GEO_DB_RAPID_API_HOST" {
  type = string
}