{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('api_keys_ab1') }}
select
    cast(website as {{ dbt_utils.type_string() }}) as website,
    {{ cast_to_boolean('active') }} as active,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(_ab_cdc_deleted_at as {{ dbt_utils.type_string() }}) as _ab_cdc_deleted_at,
    cast(_ab_cdc_lsn as {{ dbt_utils.type_float() }}) as _ab_cdc_lsn,
    cast(ips as {{ dbt_utils.type_string() }}) as ips,
    cast(app_name as {{ dbt_utils.type_string() }}) as app_name,
    cast(tier as {{ dbt_utils.type_bigint() }}) as tier,
    cast({{ adapter.quote('permissions') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('permissions') }},
    cast(_ab_cdc_updated_at as {{ dbt_utils.type_string() }}) as _ab_cdc_updated_at,
    cast(origins as {{ dbt_utils.type_string() }}) as origins,
    cast(key as {{ dbt_utils.type_string() }}) as key,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('api_keys_ab1') }}
-- api_keys
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

