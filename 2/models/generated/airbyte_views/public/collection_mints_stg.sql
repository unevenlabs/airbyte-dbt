{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('collection_mints_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'max_mints_per_wallet',
        'allowlist_id',
        'kind',
        'end_time',
        'created_at',
        '_ab_cdc_deleted_at',
        '_ab_cdc_lsn',
        'collection_id',
        'start_time',
        'stage',
        'token_id',
        'updated_at',
        'price',
        'max_supply',
        '_ab_cdc_updated_at',
        'details',
        'currency',
        'id',
        'status',
    ]) }} as _airbyte_collection_mints_hashid,
    tmp.*
from {{ ref('collection_mints_ab2') }} tmp
-- collection_mints
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

