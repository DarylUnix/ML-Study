-- Spotify Penetration Analysis by Meta
-- Reference: https://platform.stratascratch.com/coding/10369-spotify-penetration-analysis?code_type=3

-- Market penetration is an important metric for understanding Spotify's performance and growth potential in different regions.
-- You are part of the analytics team at Spotify and are tasked with calculating the active user penetration rate in specific countries.
-- For this task, 'active_users' are defined based on the  following criterias:
-- last_active_date: The user must have interacted with Spotify within the last 30 days.
-- sessions: The user must have engaged with Spotify for at least 5 sessions.
-- listening_hours: The user must have spent at least 10 hours listening on Spotify.
-- Based on the condition above, calculate the active 'user_penetration_rate' by using the following formula.
-- Active User Penetration Rate = (Number of Active Spotify Users in the Country / Total users in the Country)
-- Total Population of the country is based on both active and non-active users.
​-- The output should contain 'country' and 'active_user_penetration_rate' rounded to 2 decimals.
-- Let's assume the current_day is 2024-01-31.

## My first time encoutering timeframe related question, will google that after this
## For now I'm going to use what I know and do what I can
## Just checked other solutions and ended up with same answers. Yay!!

WITH CTE1 as
(
select *
from penetration_analysis
where year(last_active_date) = 2024 AND
month(last_active_date) = 1 AND
sessions >= 5 AND
listening_hours >= 10
),
CTE2 as
(
select country as country_A, count(*) as active_users 
from CTE1
group by country
),
CTE3 as
(
select country as country_B, count(*) as total_users 
from penetration_analysis
group by country
),
CTE4 as
(
select country_A as country, round((active_users/total_users),2) as active_user_pentration_rate
from CTE2
inner join CTE3
 on CTE2.country_A = CTE3.country_B
)
select * from CTE4
;
