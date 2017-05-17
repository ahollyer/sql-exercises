-- projects_db Exercises
-- by Aspen Hollyer

-- Problems
-- Write queries to find the answers below:


-- What are all projects that use JavaScript?
SELECT *
FROM project_uses_tech
WHERE tech_id = (SELECT id FROM tech WHERE name = 'JavaScript');
-- What are all technologies used by the Personal Website?
SELECT name
FROM tech
WHERE id IN (SELECT tech_id FROM project_uses_tech WHERE project_id = (SELECT id FROM project WHERE name = 'Personal Website'));
-- Perform a left outer join from the tech table to the project_uses_tech table - which techs has no associated project?
SELECT *
FROM tech
LEFT OUTER JOIN project_uses_tech
ON tech.id = project_uses_tech.tech_id;
-- Ruby, JavaScript, Java

-- Based on the previous query, get the count of the number of techs used by each project.
SELECT project_name, count(tech_id) AS num_techs_used
FROM(SELECT name AS project_name, tech_id
FROM project
JOIN project_uses_tech
ON project.id = project_uses_tech.project_id) AS tech_summary
GROUP BY project_name;

-- Perform a left outer join from the project table to the project_users_tech table - which projects has no associated tech?
SELECT *
FROM project
LEFT OUTER JOIN project_uses_tech
ON project.id = project_uses_tech.tech_id;
-- RPG Hero Game, Mozilla Front Page, Whiteboard Exercises

-- Based on the previous query, get the count of the number of projects that use each tech.
SELECT tech_name, count(project_id) AS num_projects_used_in
FROM (SELECT name AS tech_name, project_id
FROM tech
LEFT OUTER JOIN project_uses_tech
ON tech.id = project_uses_tech.tech_id) AS tech_summary
GROUP BY tech_name;

-- List all projects along with each technology used by it. You will need to do a three-way join.
SELECT *
FROM project
JOIN project_uses_tech
ON project_uses_tech.project_id = project.id
JOIN tech
ON project_uses_tech.tech_id = tech.id;

-- List all the distinct techs that are used by at least one project.
SELECT DISTINCT(tech.name)
FROM TECH
JOIN project_uses_tech
ON tech.id = project_uses_tech.tech_id
JOIN project
ON project.id = project_uses_tech.project_id;

-- List all the distinct techs that are not used by any projects.
SELECT DISTINCT(tech.name)
FROM TECH
LEFT OUTER JOIN project_uses_tech
ON tech.id = project_uses_tech.tech_id
LEFT OUTER JOIN project
ON project.id = project_uses_tech.project_id
WHERE project.id IS NULL;

-- List all the distinct projects that use at least one tech.
SELECT DISTINCT(project.name)
FROM project
JOIN project_uses_tech
ON project.id = project_uses_tech.project_id
JOIN tech
ON tech.id = project_uses_tech.tech_id;

-- List all the distinct projects that use no tech.
SELECT DISTINCT(project.name)
FROM project
LEFT OUTER JOIN project_uses_tech
ON project.id = project_uses_tech.project_id
LEFT OUTER JOIN tech
ON tech.id = project_uses_tech.tech_id
WHERE tech.id IS NULL;

-- Order the projects by how many tech it uses.
SELECT DISTINCT(project.name), count(tech_id) AS tech_count
FROM project
LEFT OUTER JOIN project_uses_tech
ON project.id = project_uses_tech.project_id
LEFT OUTER JOIN tech
ON tech.id = project_uses_tech.tech_id
GROUP BY project.name
ORDER BY tech_count;

-- Order the tech by how many projects use it.
SELECT DISTINCT(tech.name), count(project_id) AS projects_count
FROM TECH
LEFT OUTER JOIN project_uses_tech
ON tech.id = project_uses_tech.tech_id
LEFT OUTER JOIN project
ON project.id = project_uses_tech.project_id
GROUP BY tech.name
ORDER BY projects_count;

-- What is the average number of techs used by a project?
SELECT avg(tech_count) FROM
(SELECT DISTINCT(project.name), count(tech_id) AS tech_count
FROM project
LEFT OUTER JOIN project_uses_tech
ON project.id = project_uses_tech.project_id
LEFT OUTER JOIN tech
ON tech.id = project_uses_tech.tech_id
GROUP BY project.name) AS techs_used;
-- 2.09
