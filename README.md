### Sample Usage

```hcl
module "demo_observability" {
  source = ""github.com/dapperlabs-platform/terraform-confluent-kafka-cluster-observability?ref=tag""
  bootstrap_server = module.demo_kafka.bootstrap_endpoint
  cluster_id = module.demo_kafka.cluster_id
  confluent_env_id = "env-v7yp35"
  environment = local.environment
  kafka_lag_exporter_image_version = "0.7.1"
  name = local.name
  resource_api_version = module.demo_kafka.cluster_api_version
  resource_kind = module.demo_kafka.cluster_kind
  resource_rbac_crn = module.demo_kafka.cluster_rbac_crn
  grafana_datasource = "NFL Prometheus"

  # Depends on a usage of Kafka Official Module => https://github.com/dapperlabs-platform/terraform-confluent-official-kafka-cluster
  depends_on = [module.demo_kafka]
}
