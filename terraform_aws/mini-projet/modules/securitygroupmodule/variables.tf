variable "myssh" {
  type    = number
  default = 22
}

variable "myhttp" {
  type    = number
  default = 80
}

variable "myhttps" {
  type    = number
  default = 443
}

variable "mycidr" {
  type    = "string"
  default = "0.0.0.0/0"
}

variable "name_sec_group" {
  type    = "string"
  default = "name_sg12"
}
