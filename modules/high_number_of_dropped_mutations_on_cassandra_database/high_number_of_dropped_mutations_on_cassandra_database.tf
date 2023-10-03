resource "shoreline_notebook" "high_number_of_dropped_mutations_on_cassandra_database" {
  name       = "high_number_of_dropped_mutations_on_cassandra_database"
  data       = file("${path.module}/data/high_number_of_dropped_mutations_on_cassandra_database.json")
  depends_on = [shoreline_action.invoke_change_cassandra_config]
}

resource "shoreline_file" "change_cassandra_config" {
  name             = "change_cassandra_config"
  input_file       = "${path.module}/data/change_cassandra_config.sh"
  md5              = filemd5("${path.module}/data/change_cassandra_config.sh")
  description      = "Increase the number of Cassandra nodes to handle the increased load and ensure that there is proper replication factor to avoid any data loss."
  destination_path = "/agent/scripts/change_cassandra_config.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_change_cassandra_config" {
  name        = "invoke_change_cassandra_config"
  description = "Increase the number of Cassandra nodes to handle the increased load and ensure that there is proper replication factor to avoid any data loss."
  command     = "`chmod +x /agent/scripts/change_cassandra_config.sh && /agent/scripts/change_cassandra_config.sh`"
  params      = []
  file_deps   = ["change_cassandra_config"]
  enabled     = true
  depends_on  = [shoreline_file.change_cassandra_config]
}

