{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('cross_posting_orders_ab1') }}
select
    cast(schema as {{ dbt_utils.type_string() }}) as schema,
    cast(kind as {{ dbt_utils.type_string() }}) as kind,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(_ab_cdc_deleted_at as {{ dbt_utils.type_string() }}) as _ab_cdc_deleted_at,
    cast(_ab_cdc_lsn as {{ dbt_utils.type_float() }}) as _ab_cdc_lsn,
    cast(source as {{ dbt_utils.type_string() }}) as source,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(orderbook as {{ dbt_utils.type_string() }}) as orderbook,
    cast(_ab_cdc_updated_at as {{ dbt_utils.type_string() }}) as _ab_cdc_updated_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(status_reason as {{ dbt_utils.type_string() }}) as status_reason,
    cast(order_id as {{ dbt_utils.type_string() }}) as order_id,
    cast(raw_data as {{ dbt_utils.type_string() }}) as raw_data,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cross_posting_orders_ab1') }}
-- cross_posting_orders
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

