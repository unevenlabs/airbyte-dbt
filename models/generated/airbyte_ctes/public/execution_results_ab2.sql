{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('execution_results_ab1') }}
select
    cast(error_message as {{ dbt_utils.type_string() }}) as error_message,
    cast(api_key as {{ dbt_utils.type_string() }}) as api_key,
    cast(_ab_cdc_updated_at as {{ dbt_utils.type_string() }}) as _ab_cdc_updated_at,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(_ab_cdc_deleted_at as {{ dbt_utils.type_string() }}) as _ab_cdc_deleted_at,
    cast(tx_hash as {{ dbt_utils.type_string() }}) as tx_hash,
    cast(_ab_cdc_lsn as {{ dbt_utils.type_float() }}) as _ab_cdc_lsn,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(step_id as {{ dbt_utils.type_string() }}) as step_id,
    cast(request_id as {{ dbt_utils.type_string() }}) as request_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('execution_results_ab1') }}
-- execution_results
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

