select * from raw.azure_billing_detail;
select * from raw.azure_summary_credits;

/**
     Azure summary credits
**/

with cte_credit_usage_summary as (
	select
		split_part(service_period_utc,'-',1) as service_start_period,
		split_part(service_period_utc,'-',2) as service_end_period,
		transaction_type,product_family,product_type,product_sku,
		invoice_section,quantity,units,unit_type,charges_credits_currency,
		charges_credits,azure_credits_applied_currency,azure_credits_applied,
		tax_currency,tax,total_currency,total
	from raw.azure_summary_credits 
	where transaction_type='Credit'
),
cte_credit_tier_prdfam_audit as (
	select
		*,
		row_number() over(partition by transaction_type,product_family order by product_family desc) as rnk
	from cte_credit_usage_summary	
) 
select 
	service_start_period,
	service_end_period,
	transaction_type,
	product_family,
	product_sku,
	invoice_section,
	quantity,
	units,
	unit_type,
	charges_credits_currency,
	charges_credits,
	azure_credits_applied,
	tax,
	total
from cte_credit_tier_prdfam_audit;