packer {
  required_version = "v1.9.1"
}

locals {
  file_url           = "https://raspi.debian.net/daily/raspi_4_${var.raspi-debian-distribution-name}.img.xz"
  file_checksum_url  = "https://raspi.debian.net/daily/raspi_4_${var.raspi-debian-distribution-name}.img.xz.sha256"
}

source "arm" "raspi-debian" {
  # Remote file
  file_urls             = [local.file_url]
  file_checksum_url     = local.file_checksum_url
  file_checksum_type    = "sha256"
  file_target_extension = "xz"
  file_unarchive_cmd    = ["xz", "--decompress", "$ARCHIVE_PATH"]

  # Image config
  image_build_method    = "reuse"
  image_path            = "raspi_4_${var.raspi-debian-distribution-name}.img"
  image_size            = "3G"
  image_type            = "dos"
  image_partitions {
    name         = "boot"
    type         = "c"
    start_sector = "2048"
    filesystem   = "fat"
    size         = "256M"
    mountpoint   = "/boot/firmware"
  }
  image_partitions {
    name         = "root"
    type         = "83"
    start_sector = "526336"
    filesystem   = "ext4"
    size         = "126.8G"
    mountpoint   = "/"
  }
  image_chroot_env             = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"]

  # Qemu config
  qemu_binary_source_path      = "/usr/bin/qemu-aarch64-static"
  qemu_binary_destination_path = "/usr/bin/qemu-aarch64-static"
}

build {
  sources = ["source.arm.raspi-debian"]

  provisioner "shell" {
    inline = [
      "useradd --create-home -p $(openssl passwd -6 ${var.password}) -s /bin/bash ${var.username}",
      "usermod -aG sudo ${var.username}",
      "touch /boot/ssh",

      "mkdir /home/${var.username}/.ssh && touch /home/${var.username}/.ssh/authorized_keys",
      "chown -R kooka:kooka /home/${var.username}/.ssh && chmod 700 /home/${var.username}/.ssh && chmod 600 /home/${var.username}/.ssh/authorized_keys",
      "echo ${var.ssh-public-key} >> /home/${var.username}/.ssh/authorized_keys"
    ]
  }
}
