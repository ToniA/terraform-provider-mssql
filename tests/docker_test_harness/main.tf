resource "random_password" "mssql" {
  length  = 20
  special = false
}

resource "docker_image" "mssql" {
  name         = "mcr.microsoft.com/mssql/server:${var.mssql_version}-latest"
  keep_locally = true
}

resource "docker_container" "mssql" {
  image = docker_image.mssql.image_id
  name  = "terraform-mssql-acc-test"
  wait  = true

  env = [
    "ACCEPT_EULA=Y",
    "MSSQL_PID=${var.mssql_pid}",
    "MSSQL_SA_PASSWORD=${random_password.mssql.result}"
  ]

  ports {
    internal = 1433
    external = 11433
  }

  healthcheck {
    test = [
      "CMD", "/opt/mssql-tools18/bin/sqlcmd", "-C", "-U", "sa", "-P", "${random_password.mssql.result}", "-Q", "SELECT 1;"
    ]

    start_period = "3s"
    interval     = "1s"
    retries      = 5
  }
}
