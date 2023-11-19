CREATE OR REPLACE PROCEDURE SetTournamentWinner(p_tournament_name VARCHAR(40))
LANGUAGE plpgsql AS $$
DECLARE
    v_tournament_id INT;
    v_winner_team_id INT;
BEGIN
    -- Get the tournament ID
    SELECT tournament_id INTO v_tournament_id FROM Tournaments WHERE tournament_name = p_tournament_name;
    IF v_tournament_id IS NULL THEN
        RAISE EXCEPTION 'Tournament not found';
    END IF;

    -- Find the team with the most wins
    SELECT winner_id INTO v_winner_team_id
    FROM Matches
    WHERE tournament_id = v_tournament_id
    GROUP BY winner_id
    ORDER BY COUNT(*) DESC
    LIMIT 1;

    -- Update the tournament's winner
    UPDATE Tournaments
    SET winner_id = v_winner_team_id
    WHERE tournament_id = v_tournament_id;
END;
$$;



-- CALL SetTournamentWinner('World Championship 2023');
-- ERROR 1644 (45000) at line 608: Tournament not found

-- select winner_id from Tournaments where tournament_name='Summer Cup 2023';
-- winner_id
-- NULL
-- CALL SetTournamentWinner('Summer Cup 2023');
-- select winner_id from Tournaments where tournament_name='Summer Cup 2023';
-- winner_id
-- 1


-- -- Create the trigger

-- CREATE OR REPLACE FUNCTION trigger_function_UpdateTournamentWinner()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     CALL SetTournamentWinner(NEW.tournament_id::VARCHAR);
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE OR REPLACE TRIGGER UpdateTournamentWinner
-- AFTER INSERT ON Matches
-- FOR EACH ROW
-- EXECUTE FUNCTION trigger_function_UpdateTournamentWinner();

--procedury
CREATE OR REPLACE PROCEDURE _AddMatchToTournament(
    p_tournament_name VARCHAR(40),
    p_date_played DATE,
    p_winner_team_name VARCHAR(30),
    p_team1_name VARCHAR(30),
    p_team2_name VARCHAR(30),
    p_duration_minutes INTERVAL,
    p_player_data TEXT
)
LANGUAGE plpgsql AS $$
DECLARE
    v_tournament_id INT;
    v_winner_team_id INT;
    v_team1_id INT;
    v_team2_id INT;
    v_match_id INT;
    v_player_id INT;
    v_champion_id INT;
    v_position TEXT;
    v_level INT;
    v_statistics VARCHAR(20);
    v_dealt_damage INT;
    v_received_damage INT;
    v_earned_gold INT;
    v_item_ids TEXT;
    v_index INT := 1;
    v_player_data_entry TEXT;
    v_end_index INT;
    v_item_id1 INT;
    v_item_id2 INT;
    v_item_id3 INT;
    v_item_id4 INT;
    v_item_id5 INT;
    v_item_id6 INT;
    v_player_team_id INT;
    v_champions_team1 TEXT := '';
    v_champions_team2 TEXT := '';
    v_team1_player_count INT := 0;
    v_team2_player_count INT := 0;
    v_player_data_array TEXT[];
    v_player_entry_array TEXT[];
    v_item_array INT[];
BEGIN
    -- Add or get tournament

    SELECT tournament_id INTO v_tournament_id FROM Tournaments WHERE tournament_name = p_tournament_name;
    IF v_tournament_id IS NULL THEN
        INSERT INTO Tournaments (tournament_name) VALUES (p_tournament_name) RETURNING tournament_id INTO v_tournament_id;
    END IF;

    -- Add or get Team 1
    SELECT team_id INTO v_team1_id FROM Teams WHERE team_name = p_team1_name;
    IF v_team1_id IS NULL THEN
        INSERT INTO Teams (team_name) VALUES (p_team1_name) RETURNING team_id INTO v_team1_id;
    END IF;

    -- Add or get Team 2
    SELECT team_id INTO v_team2_id FROM Teams WHERE team_name = p_team2_name;
    IF v_team2_id IS NULL THEN
        INSERT INTO Teams (team_name) VALUES (p_team2_name) RETURNING team_id INTO v_team2_id;
    END IF;

    -- Add or get Winner Team
    SELECT team_id INTO v_winner_team_id FROM Teams WHERE team_name = p_winner_team_name;
    IF v_winner_team_id IS NULL THEN
        INSERT INTO Teams (team_name) VALUES (p_winner_team_name) RETURNING team_id INTO v_winner_team_id;
    END IF;

    -- Validation: Winner team is one of the playing teams
    IF v_winner_team_id NOT IN (v_team1_id, v_team2_id) THEN
        RAISE EXCEPTION 'Winner team is not a playing team';
    END IF;

    -- Add match details
    INSERT INTO Matches (date_played, winner_id, duration_minutes, tournament_id, team1_id, team2_id)
    VALUES (p_date_played, v_winner_team_id, p_duration_minutes, v_tournament_id, v_team1_id, v_team2_id) RETURNING match_id INTO v_match_id;

    -- Find the end index for looping
    SELECT array_length(regexp_split_to_array(p_player_data, ','), 1) INTO v_end_index;

    -- Loop through player data tuples and validate, then insert into Picks
    WHILE v_index <= v_end_index LOOP
        v_player_data_entry := (regexp_split_to_array(p_player_data, ','))[v_index];
        v_player_entry_array := regexp_split_to_array(v_player_data_entry, ':');

        -- Extract data from the serialized string
        v_player_id := v_player_entry_array[1]::INT;
        v_champion_id := v_player_entry_array[2]::INT;
        v_position := v_player_entry_array[3];
        v_level := v_player_entry_array[4]::INT;
        v_statistics := v_player_entry_array[5];
        v_dealt_damage := v_player_entry_array[6]::INT;
        v_received_damage := v_player_entry_array[7]::INT;
        v_earned_gold := v_player_entry_array[8]::INT;
        v_item_ids := v_player_entry_array[9];
        SELECT string_to_array(v_item_ids, ',') INTO v_item_array;

        -- Check if player is part of one of the teams
        SELECT team_id INTO v_player_team_id FROM Players WHERE player_id = v_player_id;
        IF v_player_team_id NOT IN (v_team1_id, v_team2_id) THEN
            RAISE EXCEPTION 'Player is not part of the playing teams';
        END IF;

        -- Count players and ensure no more than 5 per team
        IF v_player_team_id = v_team1_id THEN
            v_team1_player_count := v_team1_player_count + 1;
            IF v_team1_player_count > 5 THEN
                RAISE EXCEPTION 'More than 5 players in Team 1';
            END IF;
            -- Check for unique champions in Team 1
            IF v_champion_id::TEXT = ANY (string_to_array(v_champions_team1, ',')) THEN
                RAISE EXCEPTION 'Duplicate champion in Team 1';
            ELSE
                v_champions_team1 := v_champions_team1 || ',' || v_champion_id::TEXT;
            END IF;
        ELSIF v_player_team_id = v_team2_id THEN
            v_team2_player_count := v_team2_player_count + 1;
            IF v_team2_player_count > 5 THEN
                RAISE EXCEPTION 'More than 5 players in Team 2';
            END IF;
            -- Check for unique champions in Team 2
            IF v_champion_id::TEXT = ANY (string_to_array(v_champions_team2, ',')) THEN
                RAISE EXCEPTION 'Duplicate champion in Team 2';
            ELSE
                v_champions_team2 := v_champions_team2 || ',' || v_champion_id::TEXT;
            END IF;
        END IF;

        -- Insert into Picks
        INSERT INTO Picks (match_id, player_id, champion_id, position, level, statistics, dealt_damage, received_damage, earned_gold, item1_id, item2_id, item3_id, item4_id, item5_id, item6_id)
        VALUES (v_match_id, v_player_id, v_champion_id, v_position::picks_position, v_level, v_statistics, v_dealt_damage, v_received_damage, v_earned_gold, v_item_array[1]::INT, v_item_array[2]::INT, v_item_array[3]::INT, v_item_array[4]::INT, v_item_array[5]::INT, v_item_array[6]::INT);

        v_index := v_index + 1;
    END LOOP;
END;
$$;

CREATE OR REPLACE PROCEDURE AddMatchToTournament(
    p_tournament_name VARCHAR(40),
    p_date_played DATE,
    p_winner_team_name VARCHAR(30),
    p_team1_name VARCHAR(30),
    p_team2_name VARCHAR(30),
    p_duration_minutes INTERVAL,
    p_player_data TEXT
)
LANGUAGE plpgsql AS $$
BEGIN
    CALL _AddMatchToTournament(
        p_tournament_name, 
        p_date_played, 
        p_winner_team_name, 
        p_team1_name, 
        p_team2_name, 
        p_duration_minutes, 
        p_player_data
    );
    CALL SetTournamentWinner(p_tournament_name);
END;
$$;

-- CALL AddMatchToTournament(
--     'Summer Cup 2023', 
--     '2023-07-15', 
--     'Winner Team Name', 
--     'Team Alpha', 
--     'Team Beta', 
--     '00:35:00', 
--     '1:1:Mid:12:6/2/4:18500:12500:15000:1:2:3:4:5:6,2:7:Top:13:5/4/7:17500:13000:14800:7:8:9:10:11:12,3:10:Jungle:11:3/5/12:16000:14000:13500:13:14:15:16:17:18,4:15:Bot:11:7/3/9:19000:12700:15500:19:20:21:22:13:14,5:21:Support:10:1/4/15:13000:13500:12500:15:22:13:14:19:3,6:2:Mid:14:8/2/3:20000:12000:16000:2:4:6:8:10:12,7:8:Top:15:4/4/6:19500:12800:15700:14:16:18:20:22:14,8:13:Jungle:12:3/6/10:16800:14300:14500:22:18:13:2:4:6,9:20:Bot:13:6/2/8:18400:12600:15400:8:10:12:14:16:18,10:18:Support:11:2/5/14:13500:13900:12600:1:3:5:7:9:11'
-- );
-- psql:project1/translated_procedures.sql:227: ERROR:  Winner team is not a playing team


-- CALL AddMatchToTournament(
--     'Summer Cup 2023', 
--     '2023-07-15', 
--     'Team Alpha', 
--     'Team Alpha', 
--     'Team Beta', 
--     '00:35:00', 
--     '1:1:Mid:12:6/2/4:18500:12500:15000:1:2:3:4:5:6,2:7:Top:13:5/4/7:17500:13000:14800:7:8:9:10:11:12,3:10:Jungle:11:3/5/12:16000:14000:13500:13:14:15:16:17:18,4:15:Bot:11:7/3/9:19000:12700:15500:19:20:21:22:13:14,5:21:Support:10:1/4/15:13000:13500:12500:15:22:13:14:19:3,6:2:Mid:14:8/2/3:20000:12000:16000:2:4:6:8:10:12,7:8:Top:15:4/4/6:19500:12800:15700:14:16:18:20:22:14,8:13:Jungle:12:3/6/10:16800:14300:14500:22:18:13:2:4:6,9:20:Bot:13:6/2/8:18400:12600:15400:8:10:12:14:16:18,10:18:Support:11:2/5/14:13500:13900:12600:1:3:5:7:9:11'
-- );
-- psql:project1/translated_procedures.sql:239: ERROR:  Player is not part of the playing teams


CALL AddMatchToTournament(
    'Summer Cup 2023', 
    '2023-07-15', 
    'DWG KIA', 
    'DWG KIA', 
    'Team Liquid', 
    '00:35:00', 
    '1:1:Mid:12:6/2/4:18500:12500:15000:1:2:3:4:5:6,2:7:Top:13:5/4/7:17500:13000:14800:7:8:9:10:11:12,3:10:Jungle:11:3/5/12:16000:14000:13500:13:14:15:16:17:18,4:15:Bot:11:7/3/9:19000:12700:15500:19:20:21:22:13:14,5:21:Support:10:1/4/15:13000:13500:12500:15:22:13:14:19:3,6:2:Mid:14:8/2/3:20000:12000:16000:2:4:6:8:10:12,7:8:Top:15:4/4/6:19500:12800:15700:14:16:18:20:22:14,8:13:Jungle:12:3/6/10:16800:14300:14500:22:18:13:2:4:6,10:18:Support:11:2/5/14:13500:13900:12600:1:3:5:7:9:11,9:20:Bot:13:6/2/8:18400:12600:15400:8:10:12:14:16:18'
);

-- SELECT winner_id FROM Tournaments WHERE tournament_name='Summer Cup 2023';
--  winner_id 
-- -----------
--          1

CALL AddMatchToTournament(
    'Summer Cup 2023', 
    '2023-07-16', 
    'Team Liquid', 
    'DWG KIA', 
    'Team Liquid', 
    '00:35:00', 
    '1:1:Mid:12:6/2/4:18500:12500:15000:1:2:3:4:5:6,2:7:Top:13:5/4/7:17500:13000:14800:7:8:9:10:11:12,3:10:Jungle:11:3/5/12:16000:14000:13500:13:14:15:16:17:18,4:15:Bot:11:7/3/9:19000:12700:15500:19:20:21:22:13:14,5:21:Support:10:1/4/15:13000:13500:12500:15:22:13:14:19:3,6:2:Mid:14:8/2/3:20000:12000:16000:2:4:6:8:10:12,7:8:Top:15:4/4/6:19500:12800:15700:14:16:18:20:22:14,8:13:Jungle:12:3/6/10:16800:14300:14500:22:18:13:2:4:6,10:18:Support:11:2/5/14:13500:13900:12600:1:3:5:7:9:11,9:20:Bot:13:6/2/8:18400:12600:15400:8:10:12:14:16:18'
);
-- SELECT winner_id FROM Tournaments WHERE tournament_name='Summer Cup 2023';
--  winner_id 
-- -----------
--          1

CALL AddMatchToTournament(
    'Summer Cup 2023', 
    '2023-07-17', 
    'Team Liquid', 
    'DWG KIA', 
    'Team Liquid', 
    '00:35:00', 
    '1:1:Mid:12:6/2/4:18500:12500:15000:1:2:3:4:5:6,2:7:Top:13:5/4/7:17500:13000:14800:7:8:9:10:11:12,3:10:Jungle:11:3/5/12:16000:14000:13500:13:14:15:16:17:18,4:15:Bot:11:7/3/9:19000:12700:15500:19:20:21:22:13:14,5:21:Support:10:1/4/15:13000:13500:12500:15:22:13:14:19:3,6:2:Mid:14:8/2/3:20000:12000:16000:2:4:6:8:10:12,7:8:Top:15:4/4/6:19500:12800:15700:14:16:18:20:22:14,8:13:Jungle:12:3/6/10:16800:14300:14500:22:18:13:2:4:6,10:18:Support:11:2/5/14:13500:13900:12600:1:3:5:7:9:11,9:20:Bot:13:6/2/8:18400:12600:15400:8:10:12:14:16:18'
);
-- SELECT winner_id FROM Tournaments WHERE tournament_name='Summer Cup 2023';
--  winner_id 
-- -----------
--          2

-- select * from Tournaments;
--  tournament_id |    tournament_name    | winner_id | prize_pool 
-- ---------------+-----------------------+-----------+------------
--              1 | Worlds 2022           |         1 |    2000000
--              2 | MSI 2022              |         1 |     400000
--              3 | LCS Summer Split 2022 |         2 |      50000
--              4 | LCK Spring Split 2022 |         3 |     100000
--              5 | Summer Cup 2023       |         2 |           

-- select * from Matches;
--  match_id | date_played | winner_id | duration_minutes | tournament_id | team1_id | team2_id 
-- ----------+-------------+-----------+------------------+---------------+----------+----------
--         1 | 2023-01-15  |         1 | 00:25:00         |             1 |        1 |        2
--         2 | 2023-01-16  |         2 | 00:30:32         |             2 |        3 |        4
--         3 | 2023-01-16  |         1 | 00:28:12         |             3 |        2 |        4
--         4 | 2023-01-17  |         3 | 00:22:30         |             4 |        1 |        3
--         5 | 2023-07-15  |         1 | 00:35:00         |             5 |        1 |        2
--         6 | 2023-07-16  |         2 | 00:35:00         |             5 |        1 |        2
--         7 | 2023-07-17  |         2 | 00:35:00         |             5 |        1 |        2
-- (7 rows)

-- select * from Picks where match_id=5;
--  pick_id | match_id | player_id | champion_id | position | level | statistics | dealt_damage | received_damage | earned_gold | item1_id | item2_id | item3_id | item4_id | item5_id | item6_id 
-- ---------+----------+-----------+-------------+----------+-------+------------+--------------+-----------------+-------------+----------+----------+----------+----------+----------+----------
--       11 |        5 |         1 |           1 | Mid      |    12 | 6/2/4      |        18500 |           12500 |       15000 |        1 |          |          |          |          |         
--       12 |        5 |         2 |           7 | Top      |    13 | 5/4/7      |        17500 |           13000 |       14800 |        7 |          |          |          |          |         
--       13 |        5 |         3 |          10 | Jungle   |    11 | 3/5/12     |        16000 |           14000 |       13500 |       13 |          |          |          |          |         
--       14 |        5 |         4 |          15 | Bot      |    11 | 7/3/9      |        19000 |           12700 |       15500 |       19 |          |          |          |          |         
--       15 |        5 |         5 |          21 | Support  |    10 | 1/4/15     |        13000 |           13500 |       12500 |       15 |          |          |          |          |         
--       16 |        5 |         6 |           2 | Mid      |    14 | 8/2/3      |        20000 |           12000 |       16000 |        2 |          |          |          |          |         
--       17 |        5 |         7 |           8 | Top      |    15 | 4/4/6      |        19500 |           12800 |       15700 |       14 |          |          |          |          |         
--       18 |        5 |         8 |          13 | Jungle   |    12 | 3/6/10     |        16800 |           14300 |       14500 |       22 |          |          |          |          |         
--       19 |        5 |        10 |          18 | Support  |    11 | 2/5/14     |        13500 |           13900 |       12600 |        1 |          |          |          |          |         
--       20 |        5 |         9 |          20 | Bot      |    13 | 6/2/8      |        18400 |           12600 |       15400 |        8 |          |          |          |          |         
-- (10 rows)



-- Create the function
CREATE or replace FUNCTION CalculateTeamWinRate(p_team_name VARCHAR(30)) RETURNS DECIMAL(5,2) AS $$
DECLARE
    total_matches INT;
    total_wins INT;
    v_team_id INT;
    win_rate DECIMAL(5,2);
BEGIN
    SELECT team_id INTO v_team_id FROM Teams WHERE team_name = p_team_name;

    SELECT COUNT(*) INTO total_matches 
    FROM Matches
    WHERE team1_id = v_team_id OR team2_id = v_team_id;

    SELECT COUNT(*) INTO total_wins 
    FROM Matches
    WHERE winner_id = v_team_id;

    IF total_matches > 0 THEN
        win_rate := (total_wins::DECIMAL / total_matches) * 100;
    ELSE
        win_rate := 0;
    END IF;

    RETURN win_rate;
END;
$$ LANGUAGE plpgsql;

-- SELECT CalculateTeamWinRate('DWG KIA');
-- SELECT CalculateTeamWinRate('Team Liquid');
--  calculateteamwinrate 
-- ----------------------
--                 60.00
-- (1 row)

--  calculateteamwinrate 
-- ----------------------
--                 60.00