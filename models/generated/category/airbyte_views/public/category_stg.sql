{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('category_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'category_id',
        'name',
        'title',
        'status',
        'parent_category_id',
        'created_at',
        'updated_at',
        'created_by',
        'description'
    ]) }} as _airbyte_category_hashid,
    tmp.*
from {{ ref('category_ab2') }} tmp
-- category
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

