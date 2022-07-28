resource "grafana_folder" "confluent_cloud" {
  title = title("${var.environment} ${var.name} Confluent Cloud")
}

resource "grafana_dashboard" "kafka_lag_exporter" {
  folder = grafana_folder.confluent_cloud.id
  config_json = templatefile(
    "${path.module}/templates/kafka-lag-exporter.json",
    {
      datasource  = var.grafana_datasource
      clusterName = local.lc_name
    }
  )
}
