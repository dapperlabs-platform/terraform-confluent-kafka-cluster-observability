variable "environment" {
  description = "Application environment that uses the cluster"
  type        = string
}

variable "name" {
  description = "Kafka cluster identifier. Will be prepended by the environment value in Confluent cloud"
  type        = string
}

variable "grafana_datasource" {
  description = "Name of Grafana data source where Kafka metrics are stored"
  type        = string
  default     = null
}

variable "metric_exporters_namespace" {
  description = "Namespace to deploy exporters to"
  type        = string
  default     = "sre"
}

variable "kafka_lag_exporter_annotations" {
  description = "Lag exporter annotations"
  type        = map(string)
  default     = {}
}

variable "exporters_node_selector" {
  description = "K8S Deployment node selector for metric exporters"
  type        = map(string)
  default     = null
}

variable "kafka_lag_exporter_image_version" {
  description = "See https://github.com/seglo/kafka-lag-exporter/releases"
  type        = string
}

variable "kafka_lag_exporter_container_resources" {
  description = "Container resource limit configuration"
  type        = map(map(string))
  default = {
    requests = {
      cpu    = "250m"
      memory = "1Gi"
    }
    limits = {
      cpu    = "500m"
      memory = "2Gi"
    }
  }
}

variable "bootstrap_server" {
  type        = string
  description = "The bootstrap endpoint used by Kafka clients to connect to the Kafka cluster"
}

variable "cluster_id" {
  type        = string
  description = "Confluent Kafka Cluster Id"
}

variable "resource_api_version" {
  type        = string
  description = "The API group and version of the managed resource that the API Key associated with e.g cmk/v2"
}

variable "resource_kind" {
  type        = string
  description = "The kind of the managed resource that the API Key associated with e.g Cluster"
}

variable "confluent_env_id" {
  type        = string
  description = "The Confluent Environment in which the Kafka resources are located"
}

variable "resource_rbac_crn" {
  type        = string
  description = "A Confluent Resource Name(CRN) that specifies the scope and resource patterns necessary for the role to bind"
}
