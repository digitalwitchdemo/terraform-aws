# # Creating ssh key
# #======================

resource "tls_private_key" "rsa-4096-mykey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# save the private key
resource "local_file" "prv-key" {
  content  = tls_private_key.rsa-4096-mykey.private_key_pem
  filename = "C:/Users/smart/Documents/terraform-project/important-files/mykey1"
}

# save the public key
resource "local_file" "pub-key" {
  content  = tls_private_key.rsa-4096-mykey.public_key_openssh
  filename = "C:/Users/smart/Documents/terraform-project/important-files/mykey1.pub"
}


