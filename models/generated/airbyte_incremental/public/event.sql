{{ config(
    sort = ["_airbyte_unique_key", "_airbyte_emitted_at"],
    unique_key = "_airbyte_unique_key",
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('event_scd') }}
select
    _airbyte_unique_key,
    event_id,
    name,
    title,
    status,
    outcome,
    created_by,
    event_tag,
    event_meta,
    event_type,
    start_time at time zone INTERVAL '+05:30' as start_time,
    end_time at time zone INTERVAL '+05:30' as end_time,
    created_at at time zone INTERVAL '+05:30' as created_at,
    updated_at at time zone INTERVAL '+05:30' as updated_at,
    category_id,
    description,
    resolved_at at time zone INTERVAL '+05:30' as resolved_at,
    outcome_meta,
    display_picture,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_event_hashid
from {{ ref('event_scd') }}
-- event from {{ source('public', '_airbyte_raw_event') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

