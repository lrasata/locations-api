module "locations_api" {
  source = "./modules/locations_api"

  region                    = var.region
  environment               = var.environment
  api_locations_domain_name = var.api_locations_domain_name
  backend_certificate_arn   = var.backend_certificate_arn
  API_CITIES_GEO_DB_URL     = var.API_CITIES_GEO_DB_URL
  API_COUNTRIES_GEO_DB_URL  = var.API_COUNTRIES_GEO_DB_URL
  GEO_DB_RAPID_API_HOST     = var.GEO_DB_RAPID_API_HOST
  route_53_zone_id          = var.route_53_zone_id
  sns_topic_alerts_arn      = var.sns_topic_alerts_arn
}