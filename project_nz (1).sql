--  report based on date_stolen
select vehicle_desc as 'Name', COALESCE(color, 'NULL') AS color, date_stolen as 'Mark' from project_schema.stolen_vehicles 
order by date_stolen desc, color asc;


-- stolen vehicle rate by region
select l.region, count(s.vehicle_type) as total_stolen_vehicles, 
count(s.vehicle_type) * 100.0/CAST(REPLACE(l.population, ',', '') AS SIGNED) AS stolen_vehicle_rate
from project_schema.stolen_vehicles s
left join project_schema.locations l
on l.location_id = s.location_id 
group by 1, l.population
order by stolen_vehicle_rate desc;


-- identifying similar regions
select  m.make_name, s.color, s.model_year from project_schema.stolen_vehicles s
left join project_schema.make_details m
on m.ï»¿make_id = s.make_id
group by m.make_name, s.color, s.model_year;


    
    
 -- regions with highest average density of stolen vehicles  
select l.region, l.location_id, count(s.vehicle_type) as total_stolen_vehicles, 
count(s.vehicle_type) * 100.0/CAST(REPLACE(l.population, ',', '') AS SIGNED) AS stolen_vehicle_rate
from project_schema.stolen_vehicles s
left join project_schema.locations l
on l.location_id = s.location_id 
group by 1,2, l.population
order by stolen_vehicle_rate desc limit 3;

-- report based on 'trailer' make type
select s.location_id,s.model_year, s.vehicle_desc, s.color, s.date_stolen, m.make_name from project_schema.stolen_vehicles s
left join project_schema.make_details m
on m.make_id = s.make_id
where m.make_name = 'Trailer'
and s.location_id in (104,105,111)
and s.model_year >= 2018
order by s.location_id;
-- group by s.location_id;


