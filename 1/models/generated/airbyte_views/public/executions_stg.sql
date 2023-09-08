{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('executions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'side',
        'quantity',
        'created_at',
        '_ab_cdc_deleted_at',
        '_ab_cdc_lsn',
        'api_key',
        'calldata',
        '_ab_cdc_updated_at',
        'action',
        adapter.quote('from'),
        'id',
        adapter.quote('to'),
        'request_data',
        adapter.quote('user'),
        'value',
        'order_id',
        'request_id',
    ]) }} as _airbyte_executions_hashid,
    tmp.*
from {{ ref('executions_ab2') }} tmp
-- executions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

