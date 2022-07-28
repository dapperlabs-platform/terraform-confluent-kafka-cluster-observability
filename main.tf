terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.12.1"
    }
    grafana = {
      source  = "grafana/grafana"
      version = ">= 1.24.0"
    }
    confluent = {
      source  = "confluentinc/confluent"
      version = ">=1.0.0"
    }
  }
}

locals {
  name    = "${var.environment}-${var.name}"
  lc_name = lower(local.name)
}

# Kafka Lag Exporter Account
resource "confluent_service_account" "kafka_lag_exporter_service_account" {
  display_name = "${local.name}-kafka-lag-exporter-service-account"
  description  = "Service Account for kafka lag exporter"
}

# Kafka Lag Exporter Service Account Role Binding
resource "confluent_role_binding" "kafka_lag_exporter_cluster_role_binding" {
  principal   = "User:${confluent_service_account.kafka_lag_exporter_service_account.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = var.resource_rbac_crn
}

# Kafka Lag Exporter API Key
resource "confluent_api_key" "kafka_lag_exporter_api_key" {
  display_name = "${local.name}-kafka-lag-exporter-api-key"
  description  = "${local.name}-kafka-lag-exporter-api-key"
  owner {
    id          = confluent_service_account.kafka_lag_exporter_service_account.id
    api_version = confluent_service_account.kafka_lag_exporter_service_account.api_version
    kind        = confluent_service_account.kafka_lag_exporter_service_account.kind
  }

  managed_resource {
    id          = var.cluster_id
    api_version = var.resource_api_version
    kind        = var.resource_kind

    environment {
      id = var.confluent_env_id
    }
  }
  depends_on = [
    confluent_role_binding.kafka_lag_exporter_cluster_role_binding
  ]
}
