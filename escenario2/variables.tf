variable "libvirt_pool_name" {
  type        = string
  description = "Nombre del pool de almacenamiento libvirt."
  default     = "default"
}

variable "base_image_debian" {
  type        = string
  description = "Nombre de la imagen base Debian en el pool."
  default     = "debian13-base.qcow2"
}
