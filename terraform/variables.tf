variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
  default     = "rg-app-webflux"
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "canadacentral"
}

variable "app_name" {
  description = "Nombre de la aplicación / App Service"
  type        = string
  default     = "terraform-jearvaldor"
}

variable "container_name" {
  description = "Nombre del container registry"
  type = string
  default = "webflux1"
}

variable "docker_image" {
  description = "Imagen Docker para App Service"
  type        = string
  default     = "terraform-jearvaldor"
}

variable "docker_tag" {
  description = "Tag de la imagen Docker"
  type        = string
  default     = "latest"
}

variable "app_port" {
  description = "Puerto de la aplicación"
  type        = string
  default     = "8080"
}

variable "db_user" {
  description = "Usuario administrador de MySQL"
  type        = string
   sensitive   = true
}

variable "db_password" {
  description = "Contraseña de MySQL"
  type        = string
  sensitive   = true
}

variable "acr_login_server" {
  description = "Login server del Azure Container Registry"
  type        = string
}

variable "acr_username" {
  description = "Usuario admin del Azure Container Registry"
  type        = string
}
variable "acr_password" {
  description = "Password admin del Azure Container Registry"
  type        = string
  sensitive   = true
}



