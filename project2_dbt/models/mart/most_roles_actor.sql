{{ config(
    materialized="table",
    schema="mart"
) }}

with total_actor_roles as
(
select actor_id, 
	   count(*) total_roles 
from {{ref('dim_film_actor')}}
group by actor_id
)
select a.first_name,
	   a.last_name, 
	   b.total_roles 
from {{ref('dim_actor')}} a 
	 left join total_actor_roles b on a.actor_id = b.actor_id
order by b.total_roles desc