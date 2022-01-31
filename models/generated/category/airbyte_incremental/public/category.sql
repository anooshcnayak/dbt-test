{{ config(
    sort = ["_airbyte_unique_key", "_airbyte_emitted_at"],
    unique_key = "_airbyte_unique_key",
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('category_scd') }}
select
    _airbyte_unique_key,
    category_id,
    name,
    title,
    status,
    created_by,
    convert_timezone('Asia/Kolkata', created_at) as created_at,
    convert_timezone('Asia/Kolkata', updated_at) as updated_at,
    parent_category_id,
    description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_category_hashid
from {{ ref('category_scd') }}
-- category from {{ source('public', '_airbyte_raw_category') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

