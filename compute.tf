resource "oci_core_instance" "create_ZDM" {
  availability_domain = var.availability_domain_name == "" ? data.oci_identity_availability_domains.ADs.availability_domains[0]["name"] : var.availability_domain_name
  compartment_id      = var.compartment_ocid
  display_name        = "ZDM"
  shape               = var.instance_shape
  
  create_vnic_details {
    assign_public_ip = true
    subnet_id = oci_core_subnet.zdm_subnet.id
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID.images[0].id
    boot_volume_size_in_gbs = "50"
  }

  dynamic "shape_config" {
    for_each = local.is_flexible_node_shape ? [1] : []
    content {
      memory_in_gbs = var.instance_shape_flex_memory
      ocpus         = var.instance_shape_flex_ocpus
    }
  }

  metadata = {
    ssh_authorized_keys = tls_private_key.key.public_key_openssh
  }
}

resource "null_resource" "remote-exec" {
  depends_on = ["oci_core_instance.create_ZDM"]

  provisioner "remote-exec" {
    connection {
      agent       = false
      timeout     = "20m"
      host        = "${oci_core_instance.create_ZDM.public_ip}"
      user        = "${var.opc_user_name}"
      private_key = "${tls_private_key.key.private_key_pem}"
    }
  
    inline = [
      "zdm_path=\"https://www.zconverter.com/zdm/install.sh\"",
      "sudo wget -P /tmp/ $zdm_path --no-check-certificate >> /tmp/zdm_install.log",
      "sudo iptables -F",
      "sudo bash -C /tmp/install.sh -n -l -d 127.0.0.1 >> /tmp/zdm_install.log"
    ]
  }
}
