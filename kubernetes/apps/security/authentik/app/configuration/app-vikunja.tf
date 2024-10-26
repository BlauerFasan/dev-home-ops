# resource "authentik_group" "vikunja-group" {
#   name         = "vikunja"
#   is_superuser = false
# }

# resource "authentik_provider_oauth2" "vikunja-provider" {
#   name                = "Vikunja"
#   client_type         = "confidential"
#   client_id           = data.sops_file.secrets.data["vikunja_client-id"]
#   client_secret       = data.sops_file.secrets.data["vikunja_client-secret"]
#   redirect_uris       = [data.sops_file.secrets.data["vikunja_redirect-url"]]

#   signing_key                = "ab375600-ac9a-4058-a529-dbbc7d960e7a"

#   authorization_flow  = data.authentik_flow.default-provider-authorization-implicit-consent.id
#   authentication_flow = authentik_flow.passwordless-flow.uuid

#   property_mappings  = data.authentik_scope_mapping.oidc-scopes-vikunja.ids

#   access_code_validity   = "minutes=1"
#   access_token_validity  = "minutes=10"
#   refresh_token_validity = "days=2"
#   issuer_mode            = "per_provider"
# }

# resource "authentik_application" "vikunja-app" {
#   name              = "Vikunja"
#   slug              = "vikunja"
#   protocol_provider = authentik_provider_oauth2.vikunja-provider.id
#   open_in_new_tab   = true
#   meta_icon         = "https://vikunja.io/images/vikunja.png"
#   meta_launch_url   = data.sops_file.secrets.data["vikunja_endpoint"]
# }

# resource "authentik_policy_binding" "vikunja-app-policy-binding" {
#   target         = authentik_application.vikunja-app.uuid
#   order          = 0

#   enabled        = true

#   group          = authentik_group.vikunja-group.id
#   negate         = false
#   failure_result = false
# }