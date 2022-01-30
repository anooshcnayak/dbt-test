{{ config(
    sort = "_airbyte_emitted_at",
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('event_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'event_id',
        'event_type'
    ]) }} as _airbyte_event_hashid,
    tmp.*
from {{ ref('event_ab2') }} tmp
-- event
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

