terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_vpc_network" "store_net" {
  name = var.vps_network_name
}

resource "yandex_vpc_subnet" "store_subnet" {
  name           = var.vps_subnet_name
  zone           = var.vps_zone
  network_id     = yandex_vpc_network.store_net.id
  v4_cidr_blocks = [var.vps_subnet_cidr]
}

resource "yandex_vpc_security_group" "store_net_group" {
  name        = var.vps_security_group_name
  description = "Security group for the prod virtual machine"
  network_id  = yandex_vpc_network.store_net.id

  labels = {
    my-label = "sausage-net"
  }

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 8200
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outgoing traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
