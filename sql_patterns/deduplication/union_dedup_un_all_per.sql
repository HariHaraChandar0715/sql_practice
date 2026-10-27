
/*
Problem:
    Two upstream systems deliver customer records, and audit 
    requirements say that every source row must be retained 
    even when the same customer appears in both feeds. 
    Return id, name, and city, plus source set to the 
    originating table name. Sort by id and then source.

Output columns: id, name, city, source


Example 1

Input:

source_a:
id	city	name
1	NYC	Alice
2	LA	Bob
3	Chicago	Charlie
4	Houston	David

source_b:
id	city	name
3	Chicago	Charlie
4	Houston	David
5	Phoenix	Eve
6	Boston	Frank

Output:
id	name	city	source
1	Alice	NYC	source_a
2	Bob	LA	source_a
3	Charlie	Chicago	source_a
3	Charlie	Chicago	source_b
4	David	Houston	source_a
4	David	Houston	source_b
5	Eve	Phoenix	source_b
6	Frank	Boston	source_b

Explanation: 
Customer 3 occurs in both feeds, so both records remain: 
one is labeled source_a and the other source_b.

Constraints
Use only the records shown in the supplied tables.
Counts and calculations follow the business rules stated above.
Round numeric results to the precision shown in the output.
Return results matching the expected output schema and order.


*/


create table deduplication.source_a(
    id int,
    name varchar(75),
    city varchar(75)
)

create table deduplication.source_b(
    id int,
    name varchar(75),
    city varchar(75)
)

insert into deduplication.source_a(id,name,city)
values
(1,'NYC','Alice'),
(2,'LA','Bob'),
(3,'Chicago','Charlie'),
(4,'Houston','David');

insert into deduplication.source_b(id,name,city)
values
(3,'Chicago','Charlie'),
(4,'Houston','David'),
(5,'Phoenix','Eve'),
(6,'Boston','Frank');

/**
    Solution:
    Implemented both union and union all and understood the difference
    between them. Union will run both the select statements and return the
    intermediate result set and then removes the duplicated records based 
    on the query plan but generally duplicates are figured out based on the
    combination of values from all the columns in the select statement and
    discards the duplicated values.

    In case of union all it runs both the select statements and returns
    the intermediate result which contains duplicated records.

    In performance wise use union all and try to deduplicate after
    the union all will be the best approach for deduplication.

    For the below usage of both union and union all gives the same 
    result because the combination of values from all the columns are
    unique.
**/

WITH cte_union_all AS (
    SELECT 
    id,
    name,
    city,
    'source_a' AS source
FROM deduplication.source_a
UNION ALL
SELECT
    id,
    name,
    city,
    'source_b' AS source       
FROM deduplication.source_b
)
SELECT * FROM cte_union_all order by id;


WITH cte_union AS (
    SELECT 
    id,
    name,
    city,
    'source_a' AS source
FROM deduplication.source_a
UNION 
SELECT
    id,
    name,
    city,
    'source_b' AS source       
FROM deduplication.source_b
)
SELECT * FROM cte_union order by id;
 
