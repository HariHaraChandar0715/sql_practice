create schema raw;

CREATE TABLE raw.azure_summary_credits (
    id SERIAL PRIMARY KEY,
    date_utc DATE DEFAULT NULL,
    service_period_utc VARCHAR(100) DEFAULT NULL,
    transaction_type VARCHAR(50) DEFAULT NULL,
    product_family VARCHAR(100) DEFAULT NULL,
    product_type VARCHAR(100) DEFAULT NULL,
    product_sku VARCHAR(255) DEFAULT NULL,
    invoice_section VARCHAR(100) DEFAULT NULL,
    payg_price_currency VARCHAR(10) DEFAULT NULL,
    payg_price NUMERIC(15, 6) DEFAULT NULL,
    effective_price_currency VARCHAR(10) DEFAULT NULL,
    effective_price NUMERIC(15, 6) DEFAULT NULL,
    quantity NUMERIC(15, 6) DEFAULT NULL,
    units NUMERIC(15, 6) DEFAULT NULL,
    unit_type VARCHAR(50) DEFAULT NULL,
    exchange_rate NUMERIC(15, 6) DEFAULT NULL,
    charges_credits_currency VARCHAR(10) DEFAULT NULL,
    charges_credits NUMERIC(15, 2) DEFAULT NULL,
    azure_credits_applied_currency VARCHAR(10) DEFAULT NULL,
    azure_credits_applied NUMERIC(15, 2) DEFAULT NULL,
    tax_currency VARCHAR(10) DEFAULT NULL,
    tax NUMERIC(15, 2) DEFAULT NULL,
    total_currency VARCHAR(10) DEFAULT NULL,
    total NUMERIC(15, 2) DEFAULT NULL
);

CREATE TABLE raw.azure_granular_costs (
    invoice_id VARCHAR(50) NOT NULL,
    meter_id VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    resource_id TEXT NOT NULL,
    billing_account_id VARCHAR(100) DEFAULT NULL,
    billing_account_name VARCHAR(100) DEFAULT NULL,
    previous_invoice_id VARCHAR(50) DEFAULT NULL,
    billing_profile_id VARCHAR(100) DEFAULT NULL,
    billing_profile_name VARCHAR(100) DEFAULT NULL,
    invoice_section_id VARCHAR(100) DEFAULT NULL,
    invoice_section_name VARCHAR(100) DEFAULT NULL,
    partner_tenant_id VARCHAR(100) DEFAULT NULL,
    partner_name VARCHAR(100) DEFAULT NULL,
    reseller_name VARCHAR(100) DEFAULT NULL,
    reseller_mpn_id VARCHAR(50) DEFAULT NULL,
    customer_tenant_id VARCHAR(100) DEFAULT NULL,
    customer_name VARCHAR(100) DEFAULT NULL,
    cost_center VARCHAR(100) DEFAULT NULL,
    billing_period_start_date DATE DEFAULT NULL,
    billing_period_end_date DATE DEFAULT NULL,
    service_period_start_date DATE DEFAULT NULL,
    service_period_end_date DATE DEFAULT NULL,
    service_family VARCHAR(100) DEFAULT NULL,
    product_order_id VARCHAR(100) DEFAULT NULL,
    product_order_name VARCHAR(255) DEFAULT NULL,
    consumed_service VARCHAR(100) DEFAULT NULL,
    meter_name VARCHAR(255) DEFAULT NULL,
    meter_category VARCHAR(100) DEFAULT NULL,
    meter_sub_category VARCHAR(100) DEFAULT NULL,
    meter_region VARCHAR(100) DEFAULT NULL,
    product_id VARCHAR(100) DEFAULT NULL,
    product TEXT DEFAULT NULL,
    subscription_id VARCHAR(100) DEFAULT NULL,
    subscription_name VARCHAR(100) DEFAULT NULL,
    publisher_type VARCHAR(50) DEFAULT NULL,
    publisher_id VARCHAR(100) DEFAULT NULL,
    publisher_name VARCHAR(100) DEFAULT NULL,
    resource_group_name VARCHAR(100) DEFAULT NULL,
    resource_location VARCHAR(50) DEFAULT NULL,
    location VARCHAR(50) DEFAULT NULL,
    effective_price NUMERIC(15, 6) DEFAULT NULL,
    quantity NUMERIC(18, 9) DEFAULT NULL,
    unit_of_measure VARCHAR(50) DEFAULT NULL,
    charge_type VARCHAR(50) DEFAULT NULL,
    billing_currency VARCHAR(10) DEFAULT NULL,
    pricing_currency VARCHAR(10) DEFAULT NULL,
    cost_in_billing_currency NUMERIC(18, 9) DEFAULT NULL,
    cost_in_pricing_currency NUMERIC(18, 9) DEFAULT NULL,
    cost_in_usd NUMERIC(18, 9) DEFAULT NULL,
    payg_cost_in_billing_currency NUMERIC(18, 9) DEFAULT NULL,
    payg_cost_in_usd NUMERIC(18, 9) DEFAULT NULL,
    exchange_rate_pricing_to_billing NUMERIC(18, 9) DEFAULT NULL,
    exchange_rate_date DATE DEFAULT NULL,
    is_azure_credit_eligible BOOLEAN DEFAULT NULL,
    service_info1 TEXT DEFAULT NULL,
    service_info2 TEXT DEFAULT NULL,
    additional_info TEXT DEFAULT NULL,
    tags TEXT DEFAULT NULL,
    partner_earned_credit_rate NUMERIC(5, 2) DEFAULT NULL,
    partner_earned_credit_applied BOOLEAN DEFAULT NULL,
    payg_price NUMERIC(15, 6) DEFAULT NULL,
    frequency VARCHAR(50) DEFAULT NULL,
    term VARCHAR(50) DEFAULT NULL,
    reservation_id VARCHAR(100) DEFAULT NULL,
    reservation_name VARCHAR(100) DEFAULT NULL,
    pricing_model VARCHAR(50) DEFAULT NULL,
    unit_price NUMERIC(15, 6) DEFAULT NULL,
    cost_allocation_rule_name VARCHAR(100) DEFAULT NULL,
    provider VARCHAR(50) DEFAULT NULL,
    benefit_id VARCHAR(100) DEFAULT NULL,
    benefit_name VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (invoice_id, meter_id, date, resource_id)
);

select  table_name from information_schema.tables
where table_schema = 'raw' and 
table_type = 'BASE TABLE'
order by table_name;





COPY raw.azure_summary_credits (
    date_utc, service_period_utc, transaction_type, product_family, 
    product_type, product_sku, invoice_section, payg_price_currency, 
    payg_price, effective_price_currency, effective_price, quantity, 
    units, unit_type, exchange_rate, charges_credits_currency, 
    charges_credits, azure_credits_applied_currency, azure_credits_applied, 
    tax_currency, tax, total_currency, total
)
FROM '/Users/hariharachandar/Downloads/azure_billing_transactions.csv'
WITH (FORMAT CSV, HEADER true, DELIMITER ',');


select * from raw.azure_summary_credits;
