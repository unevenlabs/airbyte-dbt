{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('daily_api_usage_ab1') }}
select
    cast(route as {{ dbt_utils.type_string() }}) as route,
    cast(status_code as {{ dbt_utils.type_bigint() }}) as status_code,
    cast(api_key as {{ dbt_utils.type_string() }}) as api_key,
    cast(api_calls_count as {{ dbt_utils.type_bigint() }}) as api_calls_count,
    cast(_ab_cdc_updated_at as {{ dbt_utils.type_string() }}) as _ab_cdc_updated_at,
    cast(_ab_cdc_deleted_at as {{ dbt_utils.type_string() }}) as _ab_cdc_deleted_at,
    cast(_ab_cdc_lsn as {{ dbt_utils.type_float() }}) as _ab_cdc_lsn,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ empty_string_to_null('day') }} as {{ type_timestamp_with_timezone() }}) as day,
    cast(points as {{ dbt_utils.type_bigint() }}) as points,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('daily_api_usage_ab1') }}
-- daily_api_usage
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

