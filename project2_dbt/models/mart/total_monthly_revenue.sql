{{ config(
    materialized="table",
    schema="mart"
) }}

select to_char(payment_date, 'MM') MM,
	   to_char(payment_date, 'YYYY') YYYY,
	   sum(amount) total_revenue
from {{ref('fact_payment')}}
group by to_char(payment_date, 'MM'),to_char(payment_date, 'YYYY')