provider "google"{
	credentials = "${file("./key.json")}"
	project = "caramel-base-233209"
	region = "europe-west2"
}
