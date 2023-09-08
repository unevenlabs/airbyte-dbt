{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cross_posting_orders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'schema',
        'kind',
        'created_at',
        '_ab_cdc_deleted_at',
        '_ab_cdc_lsn',
        'source',
        'updated_at',
        'orderbook',
        '_ab_cdc_updated_at',
        'id',
        'status_reason',
        'order_id',
        'raw_data',
        'status',
    ]) }} as _airbyte_cross_posting_orders_hashid,
    tmp.*
from {{ ref('cross_posting_orders_ab2') }} tmp
-- cross_posting_orders
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

