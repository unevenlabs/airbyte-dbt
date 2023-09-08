{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('collection_mints_ab1') }}
select
    cast(max_mints_per_wallet as {{ dbt_utils.type_bigint() }}) as max_mints_per_wallet,
    cast(allowlist_id as {{ dbt_utils.type_string() }}) as allowlist_id,
    cast(kind as {{ dbt_utils.type_string() }}) as kind,
    cast({{ empty_string_to_null('end_time') }} as {{ type_timestamp_with_timezone() }}) as end_time,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(_ab_cdc_deleted_at as {{ dbt_utils.type_string() }}) as _ab_cdc_deleted_at,
    cast(_ab_cdc_lsn as {{ dbt_utils.type_float() }}) as _ab_cdc_lsn,
    cast(collection_id as {{ dbt_utils.type_string() }}) as collection_id,
    cast({{ empty_string_to_null('start_time') }} as {{ type_timestamp_with_timezone() }}) as start_time,
    cast(stage as {{ dbt_utils.type_string() }}) as stage,
    cast(token_id as {{ dbt_utils.type_bigint() }}) as token_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(price as {{ dbt_utils.type_bigint() }}) as price,
    cast(max_supply as {{ dbt_utils.type_bigint() }}) as max_supply,
    cast(_ab_cdc_updated_at as {{ dbt_utils.type_string() }}) as _ab_cdc_updated_at,
    cast(details as {{ dbt_utils.type_string() }}) as details,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('collection_mints_ab1') }}
-- collection_mints
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

