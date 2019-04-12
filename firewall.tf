resource "google_compute_firewall" "weylandfirewall" {
	name = "individualproject-firewall"
	network = "default"
	target_tags = ["individualproject"]
	source_ranges = ["0.0.0.0/0"]

	allow {
		protocol = "icmp"
	}	
	allow {
		protocol = "tcp"
		ports = ["80", "8080", "8081"]
	}
}
