{{ config(
    sort = ["_airbyte_unique_key", "_airbyte_emitted_at"],
    unique_key = "_airbyte_unique_key",
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('cross_posting_orders_scd') }}
select
    _airbyte_unique_key,
    schema,
    kind,
    created_at,
    _ab_cdc_deleted_at,
    _ab_cdc_lsn,
    source,
    updated_at,
    orderbook,
    _ab_cdc_updated_at,
    id,
    status_reason,
    order_id,
    raw_data,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_cross_posting_orders_hashid
from {{ ref('cross_posting_orders_scd') }}
-- cross_posting_orders from {{ source('public', '_airbyte_raw_cross_posting_orders') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

