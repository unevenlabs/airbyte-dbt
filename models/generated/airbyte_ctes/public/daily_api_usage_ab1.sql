{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_daily_api_usage') }}
select
    {{ json_extract_scalar('_airbyte_data', ['route'], ['route']) }} as route,
    {{ json_extract_scalar('_airbyte_data', ['status_code'], ['status_code']) }} as status_code,
    {{ json_extract_scalar('_airbyte_data', ['api_key'], ['api_key']) }} as api_key,
    {{ json_extract_scalar('_airbyte_data', ['api_calls_count'], ['api_calls_count']) }} as api_calls_count,
    {{ json_extract_scalar('_airbyte_data', ['_ab_cdc_updated_at'], ['_ab_cdc_updated_at']) }} as _ab_cdc_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['_ab_cdc_deleted_at'], ['_ab_cdc_deleted_at']) }} as _ab_cdc_deleted_at,
    {{ json_extract_scalar('_airbyte_data', ['_ab_cdc_lsn'], ['_ab_cdc_lsn']) }} as _ab_cdc_lsn,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['day'], ['day']) }} as day,
    {{ json_extract_scalar('_airbyte_data', ['points'], ['points']) }} as points,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_daily_api_usage') }} as table_alias
-- daily_api_usage
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

