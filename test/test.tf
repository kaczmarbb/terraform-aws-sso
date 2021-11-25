module "test" {
  source = "./.."

  name = "Administrators"
  policy_arn = "arn:aws:iam::aws:policy/AlexaForBusinessDeviceSetup"
  accounts = [
    "001004805698"
  ]
}