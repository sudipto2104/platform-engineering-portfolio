terraform {
  required_version = ">= 1.5.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

variable "image_name" {
  type    = string
  default = "taskflow:week1"
}

variable "replica_count" {
  type        = number
  default     = 1
  description = "Number of TaskFlow container replicas"
}

variable "base_port" {
  type    = number
  default = 9080
}

resource "docker_image" "taskflow" {
  name         = var.image_name
  keep_locally = true
}

resource "docker_container" "taskflow" {
  count = var.replica_count
  name  = "taskflow-replica-${count.index + 1}"
  image = docker_image.taskflow.image_id

  ports {
    internal = 8080
    external = var.base_port + count.index
  }

  env = [
    "TASKFLOW_VERSION=week1-terraform",
  ]

  labels {
    label = "app"
    value = "taskflow"
  }
  labels {
    label = "managed_by"
    value = "terraform"
  }
  labels {
    label = "replica"
    value = tostring(count.index + 1)
  }
}

output "replica_urls" {
  value = [for i in range(var.replica_count) : "http://localhost:${var.base_port + i}/health"]
}

output "replica_count" {
  value = var.replica_count
}