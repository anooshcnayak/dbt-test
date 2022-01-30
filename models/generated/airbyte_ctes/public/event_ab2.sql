{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('event_ab1') }}
select
    cast(event_tag as {{ dbt_utils.type_int() }}) as event_tag,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(status as {{ dbt_utils.type_int() }}) as status,
    cast(outcome as {{ dbt_utils.type_int() }}) as outcome,
    cast(end_time as {{ dbt_utils.type_timestamp() }}) as end_time,
    cast(event_id as {{ dbt_utils.type_bigint() }}) as event_id,
    cast(created_at as {{ dbt_utils.type_timestamp() }}) as created_at,
    cast(created_by as {{ dbt_utils.type_string() }}) as created_by,
    cast(event_meta as {{ dbt_utils.type_string() }}) as event_meta,
    cast(event_type as {{ dbt_utils.type_int() }}) as event_type,
    cast(start_time as {{ dbt_utils.type_timestamp() }}) as start_time,
    cast(updated_at as {{ dbt_utils.type_timestamp() }}) as updated_at,
    cast(category_id as {{ dbt_utils.type_int() }}) as category_id,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(resolved_at as {{ dbt_utils.type_timestamp() }}) as resolved_at,
    cast(outcome_meta as {{ dbt_utils.type_string() }}) as outcome_meta,
    cast(display_picture as {{ dbt_utils.type_string() }}) as display_picture,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('event_ab1') }}
-- event
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

