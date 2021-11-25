variable "name" {}

variable "policy_arn" {
  default = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "accounts" {
  type = set(string)
}