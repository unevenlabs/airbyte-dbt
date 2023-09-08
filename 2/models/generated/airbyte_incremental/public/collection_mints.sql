{{ config(
    sort = ["_airbyte_unique_key", "_airbyte_emitted_at"],
    unique_key = "_airbyte_unique_key",
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('collection_mints_scd') }}
select
    _airbyte_unique_key,
    max_mints_per_wallet,
    allowlist_id,
    kind,
    end_time,
    created_at,
    _ab_cdc_deleted_at,
    _ab_cdc_lsn,
    collection_id,
    start_time,
    stage,
    token_id,
    updated_at,
    price,
    max_supply,
    _ab_cdc_updated_at,
    details,
    currency,
    id,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_collection_mints_hashid
from {{ ref('collection_mints_scd') }}
-- collection_mints from {{ source('public', '_airbyte_raw_collection_mints') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

