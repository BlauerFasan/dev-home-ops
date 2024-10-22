resource "authentik_group" "whoami-group" {
  name         = "whoami"
  is_superuser = false
}

resource "authentik_provider_proxy" "whomai-provider" {
  name                = "WhoAmI"
  external_host       = data.sops_file.secrets.data["whoami_endpoint"]
  authentication_flow = authentik_flow.passwordless-flow.uuid
  authorization_flow  = data.authentik_flow.default-provider-authorization-implicit-consent.id
  mode                = "forward_single"

  access_token_validity  = "minutes=10"
  refresh_token_validity = "days=2"
}

resource "authentik_application" "whoami-app" {
  name              = "WhoAmI"
  slug              = "whoami"
  protocol_provider = authentik_provider_proxy.whomai-provider.id
  open_in_new_tab   = true
}

resource "authentik_policy_binding" "whoami-app-policy-binding" {
  target         = authentik_application.whoami-app.uuid
  order          = 0

  enabled        = true

  group          = authentik_group.whoami-group.id
  negate         = false
  failure_result = false
}

