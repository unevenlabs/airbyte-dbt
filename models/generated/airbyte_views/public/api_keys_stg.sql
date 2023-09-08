{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('api_keys_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'website',
        boolean_to_string('active'),
        'created_at',
        '_ab_cdc_deleted_at',
        '_ab_cdc_lsn',
        'ips',
        'app_name',
        'tier',
        adapter.quote('permissions'),
        '_ab_cdc_updated_at',
        'origins',
        'key',
        'email',
    ]) }} as _airbyte_api_keys_hashid,
    tmp.*
from {{ ref('api_keys_ab2') }} tmp
-- api_keys
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

