module "project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 14.1"

  name            = "Knative Tests"
  project_id      = "knative-tests"
  folder_id       = "1055082993535"
  org_id          = "22054930418"
  billing_account = var.billing_account

  # Sane project defaults
  default_service_account     = "keep"
  disable_services_on_destroy = false
  create_project_sa           = false
  random_project_id           = false
  auto_create_network         = true


  activate_apis = [
    "secretmanager.googleapis.com",
    "compute.googleapis.com",
    "cloudkms.googleapis.com",
    "certificatemanager.googleapis.com"
  ]
}

module "monitoring" {
  source                  = "./monitoring"
  project                 = module.project.project_id
  notification_channel_id = "potato"
}
