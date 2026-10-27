-- Active: 1793016274142@@127.0.0.1@5432@postgres
select * from apteon.people;
select * from apteon.age_groups;

-- Assign each person to an age group based on defined age boundaries. 
WITH cte_flg_people_age_group AS (
	SELECT
		ppl.id AS person_id,
		ppl.name AS name,
		ppl.age AS age,
		agrp.age_group_name AS age_group,
		agrp.age_group_id AS age_group_id
	FROM apteon.people ppl
	JOIN apteon.age_groups agrp
	  ON ppl.age>=agrp.age_lower_bound 
	 AND ppl.age<=agrp.age_upper_bound
),

-- Calculate the average age and rank the youngest and oldest.
-- person in each groups, resolving ties alphabetically.
cte_rnk_min_max_age_group AS (
	SELECT
		name,
		age_group,
		age_group_id,
		age,
		
		ROW_NUMBER() OVER(
          PARTITION BY age_group_id 
		  ORDER BY age ASC,person_id ASC
		) AS min_age_rnk,
		
		ROW_NUMBER() OVER(
          PARTITION BY age_group_id 
		  ORDER BY age DESC,person_id ASC
		) AS max_age_rnk,
		
		ROUND(
          AVG(age) OVER(
            PARTITION BY age_group_id
		  ), 2
		) AS avg_age_grp	
		
    FROM cte_flg_people_age_group	
),

-- Retain only the youngest and the oldest person from each age group.
cte_people_with_min_max_age_group AS (
	SELECT
		name,
		age_group,
		age,
		avg_age_grp,
		age_group_id
	FROM cte_rnk_min_max_age_group
	WHERE min_age_rnk=1 
	   OR max_age_rnk=1
)

-- Return the selected people in each age group and age order.
SELECT
	name,
	age_group,
	age,
	avg_age_grp
FROM cte_people_with_min_max_age_group 
ORDER BY age_group_id ASC,
	     age ASC,Name




























