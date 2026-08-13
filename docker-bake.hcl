variable "OCI_PREFIX" {
  default = "git.perish.top/perishfire/images"
}

variable "TAG" {
  default = "dev"
}

variable "REVISION" {
  default = "unknown"
}

variable "SOURCE" {
  default = "https://git.perish.top/PerishFire/images"
}

variable "PLATFORMS" {
  default = ["linux/amd64"]
}

variable "NETWORK" {
  default = "default"
}

group "default" {
  targets = ["forge"]
}

target "common" {
  context = "."
  network = NETWORK
  platforms = PLATFORMS
  args = {
    REVISION = REVISION
    SOURCE = SOURCE
  }
}

target "forge" {
  inherits = ["common"]
  dockerfile = "Containerfile.forge"
  tags = ["${OCI_PREFIX}/forge:${TAG}"]
}
