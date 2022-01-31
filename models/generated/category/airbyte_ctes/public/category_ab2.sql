{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('category_ab1') }}
select
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(status as {{ dbt_utils.type_int() }}) as status,
    cast(parent_category_id as {{ dbt_utils.type_int() }}) as parent_category_id,
    cast(category_id as {{ dbt_utils.type_int() }}) as category_id,
    cast(created_at as {{ dbt_utils.type_timestamp() }}) as created_at,
    cast(created_by as {{ dbt_utils.type_string() }}) as created_by,
    cast(updated_at as {{ dbt_utils.type_timestamp() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('category_ab1') }}
-- category
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

