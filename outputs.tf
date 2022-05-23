output "key-public-openssh" {
  value = tls_private_key.key.public_key_openssh
}

output "key-private-pem" {
  value = tls_private_key.key.private_key_pem
  sensitive = true
}