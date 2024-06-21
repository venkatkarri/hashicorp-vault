### We can design the config file on our requirement bases. 
## For every requirement refer the documentation and add the lines in config file 
## Here are the few config models, 
------------------------------------------------------------
Start a server with a configuration file.
$ vault server -config=/etc/vault/config.hcl

Start in "dev" mode with a custom initial root token. 
$ vault server -dev -dev-root-token-id="root"

-------------------------------------------------------------
Config_Sample_file-1: (Using the AWS KMS for seal and unseal)
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


----------------------------------------------------------------------------------------
Config_Sample_file-2:  ( To Auto-Unseal the vault by using vaults default method)
---------------------

storage "file"
{
    path = "/tmp/data"
}
 backend "consul"
{
    address = "127.0.0.1:8500"
    path = "vault"
}
listener "tcp"
{
    address = "127.0.0.1:8200"
    tls_disable = 1
}

hsm "pkcs11"             // This is one of the way to Auto-Unseal the vault by using vaults default method 
{
    lib = "/opt/hashi/64/hsm/safenet/8.3.2/libIngPKCS11.so"
    slot = "1"
    pin = "KSUserName:KSUserPassword"
    key_label = "vaulttek"
    mechanism = "0x1087" #for CKM_AES_CBC, use “0x1082”
    generate_key = "false"
}


---------------------------------------------------------------------------------------------
Sample_file-3: (simple file with basic structure) 
--------------
storage "file" { 
        path = "/home/ubuntu/vault/vault_data" 
        node_id = "node1" 
} 

listener "tcp" { 
address = "0.0.0.0:8200"
tls_disable = "true"
} 

ui = true 
api_addr = "http://0.0.0.0:8200"
disable_mlock = true 
log_level = "TRACE"
cluster_addr = "http://0.0.0.0:8201"

----------------------------------------------------------------------------------------


