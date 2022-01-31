{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_event') }}
select
    {{ json_extract_scalar('_airbyte_data', ['tag'], ['tag']) }} as event_tag,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['outcome'], ['outcome']) }} as outcome,
    {{ json_extract_scalar('_airbyte_data', ['end_time'], ['end_time']) }} as end_time,
    {{ json_extract_scalar('_airbyte_data', ['event_id'], ['event_id']) }} as event_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['created_by'], ['created_by']) }} as created_by,
    {{ json_extract_scalar('_airbyte_data', ['event_meta'], ['event_meta']) }} as event_meta,
    {{ json_extract_scalar('_airbyte_data', ['event_type'], ['event_type']) }} as event_type,
    {{ json_extract_scalar('_airbyte_data', ['start_time'], ['start_time']) }} as start_time,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['category_id'], ['category_id']) }} as category_id,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['resolved_at'], ['resolved_at']) }} as resolved_at,
    {{ json_extract_scalar('_airbyte_data', ['outcome_meta'], ['outcome_meta']) }} as outcome_meta,
    {{ json_extract_scalar('_airbyte_data', ['display_picture'], ['display_picture']) }} as display_picture,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_event') }} as table_alias
-- event
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

