{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_api_keys') }}
select
    {{ json_extract_scalar('_airbyte_data', ['website'], ['website']) }} as website,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['_ab_cdc_deleted_at'], ['_ab_cdc_deleted_at']) }} as _ab_cdc_deleted_at,
    {{ json_extract_scalar('_airbyte_data', ['_ab_cdc_lsn'], ['_ab_cdc_lsn']) }} as _ab_cdc_lsn,
    {{ json_extract_scalar('_airbyte_data', ['ips'], ['ips']) }} as ips,
    {{ json_extract_scalar('_airbyte_data', ['app_name'], ['app_name']) }} as app_name,
    {{ json_extract_scalar('_airbyte_data', ['tier'], ['tier']) }} as tier,
    {{ json_extract_scalar('_airbyte_data', ['permissions'], ['permissions']) }} as {{ adapter.quote('permissions') }},
    {{ json_extract_scalar('_airbyte_data', ['_ab_cdc_updated_at'], ['_ab_cdc_updated_at']) }} as _ab_cdc_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['origins'], ['origins']) }} as origins,
    {{ json_extract_scalar('_airbyte_data', ['key'], ['key']) }} as key,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_api_keys') }} as table_alias
-- api_keys
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

