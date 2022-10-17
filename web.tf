resource "digitalocean_droplet" "web" {
  image = "ubuntu-18-04-x64"
  name = "web"
  region = "nyc1"
  size = "s-1vcpu-1gb"
  private_networking = true
  user_data ="${file("userdata.yaml")}"
  ssh_keys = [data.digitalocean_ssh_key.terraform.id]


# Crear un repositorio.
resource "digitalocean_droplet" "Git_TF" {
  name = "Git_TF"
}

  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    #private_key = "${file(var.pvt_key)}"
    private_key = ("${path.module}/mab_terr")
    timeout = "2m"
  }

  provisioner "file" {
    source      = "${path.module}/keys.ssh"
    destination = "/root/keys.sh"
  }


  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt-get update",
      "sudo apt-get -y install nginx"
    ]
  }
          
}
