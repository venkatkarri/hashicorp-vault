### We can design the config file on our requirement bases. 
## For every requirement refer the documentation and add the lines in config file 
## Here are the few config models, 

-------------------------------------------------------------
Config_Model_file-1: 
--------------------
ui = true
  storage "file" {
  path = "/mnt/vault/data"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

 backend "consul"
{
    address = "0.0.0.0:8500"
    path = "vault"
}
 
seal "awskms" {                  // This is one of the way to Auto-Unseal the vault by using the AWS KMS  
  region     = "eu-north-1"                            // provide the aws region 
  kms_key_id = "58...-0538-487a-a590-3dsdfsddf20"      // Create the KMS key and provide the KMS Key ID 
  access_key = "AKsdfadfasdfafdsY"                     // Provide the User Access_key and Secret key 
  secret_key = "F4sdfadfasdfasdffsadfsdfl"             
}


---------------------------------------------------------------




  
