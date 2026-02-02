create  database marketing_analysis;
use marketing_analysis;
CREATE TABLE digital_campaign (
customer_id INT,
age int,
gender varchar(20),
income Int,
campaign_channel varchar(25),
campaign_type varchar(30),
ad_spend decimal (14,8),
click_through_rate decimal (12,10),
conversion_rate decimal (12,10),
website_visits int,
pages_per_visit decimal(12,10),
Time_On_Site decimal (12,10),
Social_Shares int,	
Email_Opens	int,
Email_Clicks int,	
Previous_Purchases int,	
Loyalty_Points int,
Advertising_Platform varchar (20),	
Advertising_Tool varchar(20),
Conversion tinyint
);
select count(customer_id) from digital_campaign;
show warnings limit 10;
select count(*)
from digital_campaign
where conversion in (0,1);
/*
Count how many 0s and 1s you have in conversion
*/
select conversion, count(*)
from digital_campaign
group by conversion;
/*
Run checks for nulls in:
campaign_channel
ad_spend
conversion
*/
select count(*)
from digital_campaign
where campaign_channel is NULL;

select count(*)
from digital_campaign
where ad_spend is NULL;

select count(*)
from digital_campaign
where conversion is null;

/*
Total Ad Spend
Total Conversions
Cost per Conversion
Average Click Through Rate
Average Conversion Rate
*/
select sum(ad_spend) as total_ad
from digital_campaign;

select sum(conversion) as total_converison
from digital_campaign;

select sum(ad_spend)/sum(conversion) as cost_per_conversion
from digital_campaign;
/*
for each channel
*/
select campaign_channel, sum(ad_spend)/sum(conversion) as cost_per_conversion_per_channel
from digital_campaign
group by campaign_channel;

select avg(click_through_rate) as avg_ctc
from digital_campaign;

select avg(conversion_rate) as avg_c_rate
from digital_campaign;

/*
Final Query
*/
select campaign_channel, sum(ad_spend) as total_ad, 
sum(conversion) as total_converison, 
sum(ad_spend)/sum(conversion) as cost_per_conversion, 
avg(click_through_rate) as avg_ctr, avg(conversion_rate) as avg_c_rate
from digital_campaign
group by campaign_channel;

/*
best and worst channels, Handle divide-by-zero
*/
select campaign_channel, round(sum(ad_spend)/nullif(sum(conversion),0),2) as cost_per_conversion
from digital_campaign
group by campaign_channel 
order by cost_per_conversion asc;

/*
Total website visits, Average Time on Site, Average Pages per Visit
*/
select campaign_channel, sum(website_visits) as total_visits,
avg(time_on_site), avg(pages_per_visit)
from digital_campaign
group by campaign_channel
order by sum(website_visits) desc;

/*
Combined Query
*/
select campaign_channel, round(sum(ad_spend),2) as total_ad, 
sum(conversion) as total_converison, 
round(sum(ad_spend)/nullif(sum(conversion),0),2) as cost_per_conversion, 
round(avg(click_through_rate),4) as avg_ctr, round(avg(conversion_rate),4) as avg_c_rate,
sum(website_visits) as total_visits, round(avg(time_on_site),2), round(avg(pages_per_visit),2)
from digital_campaign
group by campaign_channel
order by sum(ad_spend) desc;






























































































































































