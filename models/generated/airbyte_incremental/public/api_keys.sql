{{ config(
    sort = ["_airbyte_unique_key", "_airbyte_emitted_at"],
    unique_key = "_airbyte_unique_key",
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('api_keys_scd') }}
select
    _airbyte_unique_key,
    website,
    active,
    created_at,
    _ab_cdc_deleted_at,
    _ab_cdc_lsn,
    ips,
    app_name,
    tier,
    {{ adapter.quote('permissions') }},
    _ab_cdc_updated_at,
    origins,
    key,
    email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_api_keys_hashid
from {{ ref('api_keys_scd') }}
-- api_keys from {{ source('public', '_airbyte_raw_api_keys') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

