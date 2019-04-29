resource "google_compute_address" "static" {
	name="ipv4-address"
}
resource "google_compute_instance" "individualproject"{
	name = "individualproject"
	machine_type="n1-standard-1"
	zone = "europe-west2-c"
	tags = ["individualproject"]
	boot_disk {
		initialize_params {
			image =  "ubuntu-1804-bionic-v20190320"
		}
	}
	network_interface {
		network = "default"
		access_config {
			nat_ip = "${google_compute_address.static.address}"
		}
	}
	provisioner "file"{
		source = "script.sh"
		destination = "/tmp/script.sh"
	}
	provisioner "file"{
		source = "script2.sh"
		destination = "/tmp/script2.sh"
	}
	provisioner "file"{
		source = "script3.sh"
		destination = "/tmp/script3.sh"
	}
	provisioner "file"{
		source = "standalone.xml"
		destination = "/tmp/standalone.xml"
	}
	provisioner "remote-exec"{
		inline = [
			"sudo apt-get update",
		]
	}
	metadata{
		sshKeys = "mzgadd:${file("/home/mzgadd/.ssh/id_rsa.pub")}"
	}
	connection = {
		type = "ssh"
		user = "mzgadd"
		private_key = "${file("/home/mzgadd/.ssh/id_rsa")}"
	}
}
resource "null_resource" "install_wildfly"{
	depends_on =["google_compute_instance.individualproject"]
	connection = {
		host = "${google_compute_address.static.address}"
		type = "ssh"
		user = "mzgadd"
		private_key = "${file("/home/mzgadd/.ssh/id_rsa")}"
	}
	provisioner "remote-exec" {
		inline = [
			"sudo apt-get update",
			"sudo apt-get install dos2unix",
			"dos2unix /tmp/script.sh",
			"chmod +x /tmp/script.sh",
			"sudo sh  /tmp/script.sh",
		]
	}
}
resource "null_resource" "deploy_project"{
	depends_on = ["null_resource.install_wildfly"]
	connection = {
		host = "${google_compute_address.static.address}"
		type = "ssh"
		user = "mzgadd"
		private_key = "${file("/home/mzgadd/.ssh/id_rsa")}"
	}
	provisioner "remote-exec"{
		inline = [
			"dos2unix /tmp/script2.sh",
			"chmod +x /tmp/script2.sh",
			"sudo sh /tmp/script2.sh",
		]
	}
}
resource "null_resource" "deploy_frontend"{
	depends_on = ["null_resource.deploy_project"]
	connection = {
                host = "${google_compute_address.static.address}"
                type = "ssh"
                user = "mzgadd"
                private_key = "${file("/home/mzgadd/.ssh/id_rsa")}"
        }
        provisioner "remote-exec"{
                inline = [
			"sudo sed -i 's/NEW_URL/${google_compute_address.static.address}/g' /tmp/script3.sh",
                        "dos2unix /tmp/script3.sh",
                        "chmod +x /tmp/script3.sh",
                        "sudo sh /tmp/script3.sh",
                ]
        }
}
