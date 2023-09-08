{{ config(
    sort = ["_airbyte_unique_key", "_airbyte_emitted_at"],
    unique_key = "_airbyte_unique_key",
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('daily_api_usage_scd') }}
select
    _airbyte_unique_key,
    route,
    status_code,
    api_key,
    api_calls_count,
    _ab_cdc_updated_at,
    _ab_cdc_deleted_at,
    _ab_cdc_lsn,
    id,
    day,
    points,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_daily_api_usage_hashid
from {{ ref('daily_api_usage_scd') }}
-- daily_api_usage from {{ source('public', '_airbyte_raw_daily_api_usage') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

