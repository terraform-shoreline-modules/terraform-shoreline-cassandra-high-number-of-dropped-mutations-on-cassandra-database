terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "high_number_of_dropped_mutations_on_cassandra_database" {
  source    = "./modules/high_number_of_dropped_mutations_on_cassandra_database"

  providers = {
    shoreline = shoreline
  }
}