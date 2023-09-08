{{ config(
    sort = ["_airbyte_unique_key", "_airbyte_emitted_at"],
    unique_key = "_airbyte_unique_key",
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('executions_scd') }}
select
    _airbyte_unique_key,
    side,
    quantity,
    created_at,
    _ab_cdc_deleted_at,
    _ab_cdc_lsn,
    api_key,
    calldata,
    _ab_cdc_updated_at,
    action,
    {{ adapter.quote('from') }},
    id,
    {{ adapter.quote('to') }},
    request_data,
    {{ adapter.quote('user') }},
    value,
    order_id,
    request_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_executions_hashid
from {{ ref('executions_scd') }}
-- executions from {{ source('public', '_airbyte_raw_executions') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

