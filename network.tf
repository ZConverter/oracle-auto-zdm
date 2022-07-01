resource "oci_core_virtual_network" "vcn" {
  cidr_block     = var.vcn_cidr_block
  compartment_id = var.compartment_ocid
  display_name   = "zdm-vcn"
  dns_label      = "zdmvcn"
}

resource "oci_core_internet_gateway" "ig" {
    #Required
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_virtual_network.vcn.id

    #Optional
    display_name = var.internet_geteway
}

resource "oci_core_subnet" "zdm_subnet" {
  cidr_block                 = var.subnet_cidr_block
  display_name               = "zdm-subnet"
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.vcn.id
  dhcp_options_id            = oci_core_virtual_network.vcn.default_dhcp_options_id
  route_table_id             = oci_core_virtual_network.vcn.default_route_table_id
  security_list_ids          = [oci_core_virtual_network.vcn.default_security_list_id,oci_core_security_list.security_list.id]
  dns_label                  = "zdmsubnet"
}

resource "oci_core_default_route_table" "update_route_table" {
  manage_default_resource_id = oci_core_subnet.zdm_subnet.route_table_id

  route_rules {
    #Required
    network_entity_id = oci_core_internet_gateway.ig.id
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_security_list" "security_list" {
  compartment_id = var.compartment_ocid
  display_name   = "ZDM-security-list"
  vcn_id         = oci_core_virtual_network.vcn.id

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 53306
      min = 53306
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 139
      min = 139
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 445
      min = 445
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 111
      min = 111
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 2049
      min = 2049
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 80
      min = 80
    }
  }

  ingress_security_rules {
    protocol = "1"
    source   = "0.0.0.0/0"
  }
}
