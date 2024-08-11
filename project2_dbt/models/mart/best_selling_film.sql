{{ config(
    materialized="table",
    schema="mart"
) }}

select b.film_id,
	   b.title,
	   b.description,
	   count(*) total_selling 
from {{ref('dim_inventory')}} a,
	 {{ref('dim_film')}} b,
	 {{ref('dim_rental')}} c,
	 {{ref('fact_payment')}} d
where 1=1
and a.film_id = b.film_id
and a.inventory_id = c.inventory_id
and c.rental_id = d.rental_id
group by b.film_id,
	   b.title,
	   b.description
order by count(*) desc