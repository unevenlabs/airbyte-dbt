{{ config(
    sort = ["_airbyte_unique_key", "_airbyte_emitted_at"],
    unique_key = "_airbyte_unique_key",
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('execution_results_scd') }}
select
    _airbyte_unique_key,
    error_message,
    api_key,
    _ab_cdc_updated_at,
    created_at,
    _ab_cdc_deleted_at,
    tx_hash,
    _ab_cdc_lsn,
    id,
    step_id,
    request_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_execution_results_hashid
from {{ ref('execution_results_scd') }}
-- execution_results from {{ source('public', '_airbyte_raw_execution_results') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

