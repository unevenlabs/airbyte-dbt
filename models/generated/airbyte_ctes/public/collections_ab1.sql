{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_collections') }}
select
    {{ json_extract_scalar('_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['new_royalties'], ['new_royalties']) }} as new_royalties,
    {{ json_extract_scalar('_airbyte_data', ['floor_sell_source_id_int'], ['floor_sell_source_id_int']) }} as floor_sell_source_id_int,
    {{ json_extract_scalar('_airbyte_data', ['non_flagged_floor_sell_id'], ['non_flagged_floor_sell_id']) }} as non_flagged_floor_sell_id,
    {{ json_extract_scalar('_airbyte_data', ['token_id_range'], ['token_id_range']) }} as token_id_range,
    {{ json_extract_scalar('_airbyte_data', ['normalized_floor_sell_value'], ['normalized_floor_sell_value']) }} as normalized_floor_sell_value,
    {{ json_extract_scalar('_airbyte_data', ['top_buy_maker'], ['top_buy_maker']) }} as top_buy_maker,
    {{ json_extract_scalar('_airbyte_data', ['normalized_floor_sell_source_id_int'], ['normalized_floor_sell_source_id_int']) }} as normalized_floor_sell_source_id_int,
    {{ json_extract_scalar('_airbyte_data', ['token_set_id'], ['token_set_id']) }} as token_set_id,
    {{ json_extract_scalar('_airbyte_data', ['all_time_volume'], ['all_time_volume']) }} as all_time_volume,
    {{ json_extract_scalar('_airbyte_data', ['last_metadata_sync'], ['last_metadata_sync']) }} as last_metadata_sync,
    {{ json_extract_scalar('_airbyte_data', ['day30_volume'], ['day30_volume']) }} as day30_volume,
    {{ json_extract_scalar('_airbyte_data', ['day1_volume_change'], ['day1_volume_change']) }} as day1_volume_change,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['slug'], ['slug']) }} as slug,
    {{ json_extract_scalar('_airbyte_data', ['top_buy_source_id_int'], ['top_buy_source_id_int']) }} as top_buy_source_id_int,
    {{ json_extract_scalar('_airbyte_data', ['index_metadata'], ['index_metadata']) }} as index_metadata,
    {{ json_extract_scalar('_airbyte_data', ['floor_sell_maker'], ['floor_sell_maker']) }} as floor_sell_maker,
    {{ json_extract_scalar('_airbyte_data', ['non_flagged_floor_sell_value'], ['non_flagged_floor_sell_value']) }} as non_flagged_floor_sell_value,
    {{ json_extract_scalar('_airbyte_data', ['day7_volume_change'], ['day7_volume_change']) }} as day7_volume_change,
    {{ json_extract_scalar('_airbyte_data', ['contract'], ['contract']) }} as contract,
    {{ json_extract_scalar('_airbyte_data', ['community'], ['community']) }} as community,
    {{ json_extract_scalar('_airbyte_data', ['non_flagged_floor_sell_valid_between'], ['non_flagged_floor_sell_valid_between']) }} as non_flagged_floor_sell_valid_between,
    {{ json_extract_scalar('_airbyte_data', ['normalized_floor_sell_id'], ['normalized_floor_sell_id']) }} as normalized_floor_sell_id,
    {{ json_extract_scalar('_airbyte_data', ['day1_volume'], ['day1_volume']) }} as day1_volume,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['marketplace_fees'], ['marketplace_fees']) }} as marketplace_fees,
    {{ json_extract_scalar('_airbyte_data', ['all_time_rank'], ['all_time_rank']) }} as all_time_rank,
    {{ json_extract_scalar('_airbyte_data', ['day7_volume'], ['day7_volume']) }} as day7_volume,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['_ab_cdc_deleted_at'], ['_ab_cdc_deleted_at']) }} as _ab_cdc_deleted_at,
    {{ json_extract_scalar('_airbyte_data', ['floor_sell_source_id'], ['floor_sell_source_id']) }} as floor_sell_source_id,
    {{ json_extract_scalar('_airbyte_data', ['non_flagged_floor_sell_maker'], ['non_flagged_floor_sell_maker']) }} as non_flagged_floor_sell_maker,
    {{ json_extract_scalar('_airbyte_data', ['token_count'], ['token_count']) }} as token_count,
    {{ json_extract_scalar('_airbyte_data', ['day30_floor_sell_value'], ['day30_floor_sell_value']) }} as day30_floor_sell_value,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['top_buy_id'], ['top_buy_id']) }} as top_buy_id,
    {{ json_extract_scalar('_airbyte_data', ['owner_count'], ['owner_count']) }} as owner_count,
    {{ json_extract_scalar('_airbyte_data', ['day1_floor_sell_value'], ['day1_floor_sell_value']) }} as day1_floor_sell_value,
    {{ json_extract_scalar('_airbyte_data', ['non_flagged_floor_sell_source_id_int'], ['non_flagged_floor_sell_source_id_int']) }} as non_flagged_floor_sell_source_id_int,
    {{ json_extract_scalar('_airbyte_data', ['floor_sell_value'], ['floor_sell_value']) }} as floor_sell_value,
    {{ json_extract_scalar('_airbyte_data', ['floor_sell_valid_between'], ['floor_sell_valid_between']) }} as floor_sell_valid_between,
    {{ json_extract_scalar('_airbyte_data', ['creator'], ['creator']) }} as creator,
    {{ json_extract_scalar('_airbyte_data', ['minted_timestamp'], ['minted_timestamp']) }} as minted_timestamp,
    {{ json_extract_scalar('_airbyte_data', ['top_buy_value'], ['top_buy_value']) }} as top_buy_value,
    {{ json_extract_scalar('_airbyte_data', ['non_flagged_token_set_id'], ['non_flagged_token_set_id']) }} as non_flagged_token_set_id,
    {{ json_extract_scalar('_airbyte_data', ['_ab_cdc_lsn'], ['_ab_cdc_lsn']) }} as _ab_cdc_lsn,
    {{ json_extract_scalar('_airbyte_data', ['normalized_floor_sell_maker'], ['normalized_floor_sell_maker']) }} as normalized_floor_sell_maker,
    {{ json_extract_scalar('_airbyte_data', ['royalties_bps'], ['royalties_bps']) }} as royalties_bps,
    {{ json_extract_scalar('_airbyte_data', ['payment_tokens'], ['payment_tokens']) }} as payment_tokens,
    {{ json_extract_scalar('_airbyte_data', ['top_buy_valid_between'], ['top_buy_valid_between']) }} as top_buy_valid_between,
    {{ json_extract_scalar('_airbyte_data', ['floor_sell_id'], ['floor_sell_id']) }} as floor_sell_id,
    {{ json_extract_scalar('_airbyte_data', ['day30_rank'], ['day30_rank']) }} as day30_rank,
    {{ json_extract_scalar('_airbyte_data', ['royalties'], ['royalties']) }} as royalties,
    {{ json_extract_scalar('_airbyte_data', ['day30_volume_change'], ['day30_volume_change']) }} as day30_volume_change,
    {{ json_extract_scalar('_airbyte_data', ['_ab_cdc_updated_at'], ['_ab_cdc_updated_at']) }} as _ab_cdc_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['day7_rank'], ['day7_rank']) }} as day7_rank,
    {{ json_extract_scalar('_airbyte_data', ['day1_rank'], ['day1_rank']) }} as day1_rank,
    {{ json_extract_scalar('_airbyte_data', ['day7_floor_sell_value'], ['day7_floor_sell_value']) }} as day7_floor_sell_value,
    {{ json_extract_scalar('_airbyte_data', ['normalized_floor_sell_valid_between'], ['normalized_floor_sell_valid_between']) }} as normalized_floor_sell_valid_between,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_collections') }} as table_alias
-- collections
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

