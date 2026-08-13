variable "OCI_PREFIX" {
  default = "registry.invalid/perish/images"
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
  targets = ["base", "node", "go", "rust", "python"]
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

target "base" {
  inherits = ["common"]
  dockerfile = "Containerfile.base"
  tags = ["${OCI_PREFIX}-base:${TAG}"]
}

target "node" {
  inherits = ["common"]
  dockerfile = "Containerfile.node"
  tags = ["${OCI_PREFIX}-node:${TAG}"]
}

target "go" {
  inherits = ["common"]
  dockerfile = "Containerfile.go"
  tags = ["${OCI_PREFIX}-go:${TAG}"]
}

target "rust" {
  inherits = ["common"]
  dockerfile = "Containerfile.rust"
  tags = ["${OCI_PREFIX}-rust:${TAG}"]
}

target "python" {
  inherits = ["common"]
  dockerfile = "Containerfile.python"
  tags = ["${OCI_PREFIX}-python:${TAG}"]
}
