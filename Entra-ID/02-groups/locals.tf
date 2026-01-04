locals {
  # Common naming prefix (used only for consistent naming conventions).
  name_prefix = "${var.project}-${var.environment}"

  # Normalize user input so main.tf can rely on consistent types:
  # - owners_object_ids / members_object_ids are never null (always lists)
  # - mail_nickname is deterministic if omitted
  # - display_name is trimmed
  groups = {
    for k, g in var.groups :
    k => merge(
      # Defaults (safe types)
      {
        description        = null
        mail_nickname      = null
        owners_object_ids  = []
        members_object_ids = []
        security_enabled   = true
        mail_enabled       = false
      },

      # User input (keeps fields like display_name, description, etc.)
      g,

      # Normalized/override values (final truth used by resources)
      {
        display_name = trimspace(g.display_name)

        description = (
          try(g.description, null) != null && length(trimspace(try(g.description, ""))) > 0
        ) ? trimspace(g.description) : null

        owners_object_ids  = coalesce(try(g.owners_object_ids, null), [])
        members_object_ids = coalesce(try(g.members_object_ids, null), [])

        mail_nickname = (
          try(g.mail_nickname, null) != null && length(trimspace(g.mail_nickname)) > 0
          ) ? trimspace(g.mail_nickname) : lower(
          trim(replace(trimspace(g.display_name), "/[^0-9A-Za-z]+/", "-"), "-")
        )
      }
    )
  }
}
