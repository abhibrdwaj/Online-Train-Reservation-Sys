-- Northeast Corridor Line
-- Major Stations:

-- New York Penn Station
-- Newark Penn Station
-- Trenton
-- Metropark
-- New Brunswick
-- Princeton Junction
-- Hamilton
-- Secaucus Junction
-- Smaller Stations:

-- Jersey Avenue
-- North Brunswick
-- Edison
-- Iselin
-- Avenel
-- Rahway
-- North Jersey Coast Line
-- Major Stations:

-- Bay Head
-- Long Branch
-- Red Bank
-- Middletown
-- Hazlet
-- South Amboy
-- Perth Amboy
-- Hoboken Terminal
-- Smaller Stations:

-- Point Pleasant
-- Manasquan
-- Belmar
-- Spring Lake
-- Bradley Beach
-- Asbury Park
-- Allenhurst
-- Deal
-- Raritan Valley Line
-- Major Stations:

-- Newark Penn Station
-- Bridgewater
-- High Bridge
-- Somerville
-- Smaller Stations:

-- Raritan
-- Bound Brook
-- Dunellen
-- Fanwood
-- Westfield
-- Cranford
-- Garwood
-- Roselle Park
-- Montclair-Boonton Line
-- Major Stations:

-- Montclair State University
-- Hoboken Terminal
-- Smaller Stations:

-- Walnut Street
-- Upper Montclair
-- Little Falls
-- Boonton
-- Denville
-- Rockaway
-- Parsippany-Troy Hills
-- Gladstone Branch
-- Major Stations:

-- Gladstone
-- Summit
-- Smaller Stations:

-- Peapack
-- Far Hills
-- Bedminster
-- Bernardsville
-- Main Line
-- Major Stations:

-- Hoboken Terminal
-- Secaucus Junction
-- Smaller Stations:

-- Ridgewood
-- Waldwick
-- Ramsey
-- Suffern
-- Bergen County Line
-- Major Stations:

-- Hoboken Terminal
-- Secaucus Junction
-- Smaller Stations:

-- Ridgewood
-- Waldwick
-- Ramsey
-- Suffern
-- Hawthorne
-- Glen Rock
-- Atlantic City Line
-- Major Stations:

-- Philadelphia
-- Atlantic City
-- Smaller Stations:

-- Pennsauken
-- Cherry Hill
-- Hammonton
-- Egg Harbor City
-- Absecon
-- Pleasantville
-- River Line
-- Major Stations:

-- Camden
-- Smaller Stations:

-- Burlington City
-- Bordentown
-- Trenton
-- Riverside
-- Palmyra
-- Light Rail Stations
-- Newark Light Rail:

-- Newark Penn Station
-- Broad Street Station
-- Military Park
-- Washington Park
-- Hudson-Bergen Light Rail:

-- Hoboken Terminal
-- Jersey City
-- Weehawken
-- Bayonne
-- West New York
-- North Bergen

INSERT INTO train (transit_line_name) 
VALUES 
    ('Northeast Corridor Line'),
    ('North Jersey Coast Line'),
    ('Raritan Valley Line'),
    ('Montclair-Boonton Line'),
    ('Gladstone Branch'),
    ('Main Line'),
    ('Bergen County Line'),
    ('Atlantic City Line'),
    ('River Line'),
    ('Newark Light Rail'),
    ('Hudson-Bergen Light Rail');

-- SEED Station Values
INSERT INTO station (station_name, city, state) 
VALUES 
    ('New Brunswick', 'New Brunswick', 'New Jersey'),
    ('Trenton', 'Trenton', 'New Jersey'),
    ('Hamilton', 'Hamilton', 'New Jersey'),
    ('Princeton Junction', 'Princeton', 'New Jersey'),
    ('Metropark', 'Iselin', 'New Jersey'),
    ('Secaucus Junction', 'Secaucus', 'New Jersey'),
    ('New York Penn Station', 'New York', 'New York'),
    ('Jersey Avenue', 'New Brunswick', 'New Jersey'),
    ('North Brunswick', 'North Brunswick', 'New Jersey'),
    ('Edison', 'Edison', 'New Jersey'),
    ('Avenel', 'Avenel', 'New Jersey'),
    ('Rahway', 'Rahway', 'New Jersey'),
    ('Bay Head', 'Bay Head', 'New Jersey'),
    ('Point Pleasant Beach', 'Point Pleasant Beach', 'New Jersey'),
    ('Long Branch', 'Long Branch', 'New Jersey'),
    ('Red Bank', 'Red Bank', 'New Jersey'),
    ('Middletown', 'Middletown', 'New Jersey'),
    ('Hazlet', 'Hazlet', 'New Jersey'),
    ('South Amboy', 'South Amboy', 'New Jersey'),
    ('Perth Amboy', 'Perth Amboy', 'New Jersey'),
    ('Montclair State University', 'Montclair', 'New Jersey'),
    ('Hoboken Terminal', 'Hoboken', 'New Jersey'),
    ('Gladstone', 'Gladstone', 'New Jersey'),
    ('Summit', 'Summit', 'New Jersey'),
    ('High Bridge', 'High Bridge', 'New Jersey'),
    ('Raritan', 'Raritan', 'New Jersey'),
    ('Bridgewater', 'Bridgewater', 'New Jersey'),
    ('Somerville', 'Somerville', 'New Jersey'),
    ('Bound Brook', 'Bound Brook', 'New Jersey'),
    ('Dunellen', 'Dunellen', 'New Jersey'),
    ('Fanwood', 'Fanwood', 'New Jersey'),
    ('Westfield', 'Westfield', 'New Jersey'),
    ('Cranford', 'Cranford', 'New Jersey'),
    ('Garwood', 'Garwood', 'New Jersey'),
    ('Roselle Park', 'Roselle Park', 'New Jersey'),
    ('Little Falls', 'Little Falls', 'New Jersey'),
    ('Boonton', 'Boonton', 'New Jersey'),
    ('Denville', 'Denville', 'New Jersey'),
    ('Ridgewood', 'Ridgewood', 'New Jersey'),
    ('Waldwick', 'Waldwick', 'New Jersey'),
    ('Ramsey', 'Ramsey', 'New Jersey'),
    ('Suffern', 'Suffern', 'New Jersey'),
    ('Philadelphia', 'Philadelphia', 'Pennsylvania'),
    ('Pennsauken', 'Pennsauken', 'New Jersey'),
    ('Cherry Hill', 'Cherry Hill', 'New Jersey'),
    ('Hammonton', 'Hammonton', 'New Jersey'),
    ('Egg Harbor City', 'Egg Harbor City', 'NeTrentonw Jersey'),
    ('Atlantic City', 'Atlantic City', 'New Jersey'),
    ('Camden', 'Camden', 'New Jersey'),
    ('Burlington City', 'Burlington City', 'New Jersey'),
    ('Bordentown', 'Bordentown', 'New Jersey'),
    ('Riverside', 'Riverside', 'New Jersey'),
    ('Palmyra', 'Palmyra', 'New Jersey'),
    ('Military Park', 'Newark', 'New Jersey'),
    ('Washington Park', 'Newark', 'New Jersey'),
    ('Harrison', 'Harrison', 'New Jersey'),
    ('Bayonne', 'Bayonne', 'New Jersey'),
    ('Weehawken', 'Weehawken', 'New Jersey'),
    ('West New York', 'West New York', 'New Jersey'),
    ('South Orange', 'South Orange', 'New Jersey');

INSERT INTO transit_lines (transit_line_name, origin_station_id, destination_station_id) 
VALUES 
    ('Northeast Corridor Line', 7, 2),  -- NY Penn Station to Trenton
    ('North Jersey Coast Line', 13, 22),   -- Bay Head to Hoboken Terminal
    ('Raritan Valley Line', 32, 6),       -- High Bridge to Newark Penn Station
    ('Montclair-Boonton Line', 38, 33),    -- Hackettstown to Montclair State University
    ('Gladstone Branch', 42, 23),          -- Gladstone to Hoboken Terminal
    ('Main Line', 45, 23),                -- Suffern to Hoboken Terminal
    ('Bergen County Line', 23, 45),       -- Hoboken Terminal to Suffern
    ('Atlantic City Line', 47, 46),      -- Philadelphia to Atlantic City
    ('River Line', 52, 1),                -- Camden to New Brunswick
    ('Newark Light Rail', 60, 61),        -- Newark Penn Station to Broad Street Station
    ('Hudson-Bergen Light Rail', 63, 64), -- Bayonne to Tonnelle Avenue
    ('Northeast Corridor Line (Extended)', 7, 8), -- NY Penn Station to Jersey Avenue
    ('Raritan Valley Line (Express Service)', 7, 6), -- NY Penn Station to Newark Penn Station
    ('North Jersey Coast Line (Weekday Service)', 7, 12), -- NY Penn Station to Long Branch
    ('Montclair-Boonton Line (Midtown Direct Service)', 7, 38), -- NY Penn Station to Montclair State University
    ('Main Line (Direct Service)', 7, 45); -- NY Penn Station to Suffern




SELECT * FROM Train;
SELECT * FROM Station;