{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('executions_ab1') }}
select
    cast(side as {{ dbt_utils.type_string() }}) as side,
    cast(quantity as {{ dbt_utils.type_bigint() }}) as quantity,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(_ab_cdc_deleted_at as {{ dbt_utils.type_string() }}) as _ab_cdc_deleted_at,
    cast(_ab_cdc_lsn as {{ dbt_utils.type_float() }}) as _ab_cdc_lsn,
    cast(api_key as {{ dbt_utils.type_string() }}) as api_key,
    cast(calldata as {{ dbt_utils.type_string() }}) as calldata,
    cast(_ab_cdc_updated_at as {{ dbt_utils.type_string() }}) as _ab_cdc_updated_at,
    cast(action as {{ dbt_utils.type_string() }}) as action,
    cast({{ adapter.quote('from') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('from') }},
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ adapter.quote('to') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('to') }},
    cast(request_data as {{ dbt_utils.type_string() }}) as request_data,
    cast({{ adapter.quote('user') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('user') }},
    cast(value as {{ dbt_utils.type_bigint() }}) as value,
    cast(order_id as {{ dbt_utils.type_string() }}) as order_id,
    cast(request_id as {{ dbt_utils.type_string() }}) as request_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('executions_ab1') }}
-- executions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

