output "welcome_file_path" {
  description = "Path to the welcome file"
  value       = local_file.welcome.filename
}

output "info_file_path" {
  description = "Path to the info JSON file"
  value       = local_file.info.filename
}

output "config_file_path" {
  description = "Path to the config file"
  value       = local_file.config.filename
}

output "all_files" {
  description = "All created file paths"
  value = [
    local_file.welcome.filename,
    local_file.info.filename,
    local_file.config.filename,
    local_file.readme.filename
  ]
}

output "project_info" {
  description = "Project information"
  value = {
    name        = var.project_name
    environment = var.environment
  }
}
