{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('daily_api_usage_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'route',
        'status_code',
        'api_key',
        'api_calls_count',
        '_ab_cdc_updated_at',
        '_ab_cdc_deleted_at',
        '_ab_cdc_lsn',
        'id',
        'day',
        'points',
    ]) }} as _airbyte_daily_api_usage_hashid,
    tmp.*
from {{ ref('daily_api_usage_ab2') }} tmp
-- daily_api_usage
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

