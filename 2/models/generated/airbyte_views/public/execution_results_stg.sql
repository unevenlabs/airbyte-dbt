{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('execution_results_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'error_message',
        'api_key',
        '_ab_cdc_updated_at',
        'created_at',
        '_ab_cdc_deleted_at',
        'tx_hash',
        '_ab_cdc_lsn',
        'id',
        'step_id',
        'request_id',
    ]) }} as _airbyte_execution_results_hashid,
    tmp.*
from {{ ref('execution_results_ab2') }} tmp
-- execution_results
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

