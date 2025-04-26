# Output the private key (PEM format)
output "private_key_pem" {
  value     = tls_private_key.rsa-4096-mykey.private_key_pem
  sensitive = true  # Hides it unless explicitly requested (terraform output -json or -raw)
}

# Output the public key (OpenSSH format)
output "public_key_openssh" {
  value = tls_private_key.rsa-4096-mykey.public_key_openssh
}