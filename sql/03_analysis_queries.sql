--Query 1. Top 10 states with most property damage--

SELECT severe_weather.STATE,
SUM(severe_weather.damage_property_usd) as total_damage
FROM severe_weather
GROUP BY STATE
ORDER BY total_damage DESC
LIMIT 10;

--Query 2. Is severe weather getting worse over time?--
SELECT severe_weather.YEAR,
COUNT(severe_weather.EVENT_ID) as total_events,
SUM(damage_property_usd) as total_damage
FROM severe_weather
GROUP BY YEAR
ORDER BY YEAR;

--Query 3. What is the most common weather event in each state?--
SELECT EVENT_TYPE, STATE, max(total_events) as top_count
       FROM (SELECT EVENT_TYPE, STATE, COUNT(EVENT_ID) AS total_events

FROM severe_weather
        GROUP BY severe_weather.EVENT_TYPE, severe_weather.STATE) AS sub
GROUP BY STATE
ORDER BY STATE;

--Query 4. Which weather event type causes the most deaths nationally?--
SELECT severe_weather.EVENT_TYPE,
       SUM(severe_weather.DEATHS_INDIRECT+severe_weather.DEATHS_DIRECT) AS total_deaths

FROM severe_weather
group by EVENT_TYPE
ORDER BY total_deaths DESC
limit 10;

--Query 5. Which single storm episode caused the most total property damage?--
SELECT EPISODE_ID, STATE,max(total_episode_damage),YEAR
       FROM (SELECT EPISODE_ID,STATE, YEAR, COUNT(EVENT_ID), SUM(damage_property_usd) AS total_episode_damage
FROM
    severe_weather
GROUP BY STATE, EPISODE_ID, YEAR
) as Sub

ORDER BY "max(total_episode_damage)" DESC
LIMIT 1;
