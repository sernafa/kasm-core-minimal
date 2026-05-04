group "default" {
  targets = ["kasm-core-minimal"]
}

target "kasm-core-minimal" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["yusiwen/kasm-core-minimal:1.3.4"]
  args = {
  }
  no-cache = true
  platforms = ["linux/amd64", "linux/arm64"]
}

target "kasm-core-minimal-systemd" {
  context = "."
  dockerfile = "Dockerfile.systemd"
  tags = ["yusiwen/kasm-core-minimal:1.3.4-systemd"]
  args = {
    BASE_IMAGE = "antmelekhin/docker-systemd:ubuntu-24.04"
  }
  no-cache = true
  platforms = ["linux/amd64", "linux/arm64"]
}

target "kasm-core-minimal_1-4-0" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["yusiwen/kasm-core-minimal:1.4.0"]
  args = {
    COMMIT_ID = "9195a4f0cc6c81a8b816ef02554acad53424c73f"
    KASMVNC_VER = "1.4.0"
  }
  no-cache = true
  platforms = ["linux/amd64", "linux/arm64"]
}

target "kasm-core-minimal-systemd_1-4-0" {
  context = "."
  dockerfile = "Dockerfile.systemd"
  tags = ["yusiwen/kasm-core-minimal:1.4.0-systemd"]
  args = {
    BASE_IMAGE = "antmelekhin/docker-systemd:ubuntu-24.04"
    COMMIT_ID = "9195a4f0cc6c81a8b816ef02554acad53424c73f"
    KASMVNC_VER = "1.4.0"
  }
  no-cache = true
  platforms = ["linux/amd64", "linux/arm64"]
}

target "kasm-core-minimal_1-4-1" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["yusiwen/kasm-core-minimal:1.4.1"]
  args = {
    COMMIT_ID = "674fb67ba321cc6f05c2a4055aff09b09feb8a52"
    BRANCH = "master"
    KASMVNC_VER = "1.4.1"
  }
  no-cache = true
  platforms = ["linux/amd64", "linux/arm64"]
}

target "kasm-core-minimal-systemd_1-4-1" {
  context = "."
  dockerfile = "Dockerfile.systemd"
  tags = ["yusiwen/kasm-core-minimal:1.4.1-systemd"]
  args = {
    BASE_IMAGE = "antmelekhin/docker-systemd:ubuntu-24.04"
    COMMIT_ID = "674fb67ba321cc6f05c2a4055aff09b09feb8a52"
    BRANCH = "master"
    KASMVNC_VER = "1.4.1"
  }
  no-cache = true
  platforms = ["linux/amd64", "linux/arm64"]
}
