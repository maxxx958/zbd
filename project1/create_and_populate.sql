USE league;
DROP TABLE Tournaments;
DROP TABLE Teams;
-- Check if the table exists, and create it if it doesn't
CREATE TABLE Tournaments (
    tournament_id INT AUTO_INCREMENT PRIMARY KEY,
    tournament_name VARCHAR(255) NOT NULL UNIQUE,
    winner_id INT,
    prize_pool INT
);

CREATE TABLE Teams (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(255) NOT NULL UNIQUE
);

-- Add a foreign key constraint
ALTER TABLE Tournaments
ADD FOREIGN KEY (winner_id) REFERENCES Teams(team_id);

-- Insert teams
INSERT INTO Teams (team_name) VALUES
    ('DWG KIA'),
    ('Team Liquid'),
    ('T1'),
    ('G2');


-- Insert example data into the table
INSERT INTO Tournaments (tournament_name, winner_id, prize_pool) VALUES
    ('Worlds 2022', 1, 2000000),
    ('MSI 2022', 1, 400000),
    ('LCS Summer Split 2022', 2, 50000),
    ('LCK Spring Split 2022', 3, 100000);

-- Display the contents of the table
SELECT * FROM Tournaments;
SELECT * FROM Teams;
