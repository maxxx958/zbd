USE league;

CALL AddMatchToTournament(
    'Summer Cup 2023', 
    '2023-07-15', 
    'DWG KIA', 
    'DWG KIA', 
    'Team Liquid', 
    '00:35:00', 
    '1:1:Mid:12:6/2/4:18500:12500:15000:1:2:3:4:5:6,2:7:Top:13:5/4/7:17500:13000:14800:7:8:9:10:11:12,3:10:Jungle:11:3/5/12:16000:14000:13500:13:14:15:16:17:18,4:15:Bot:11:7/3/9:19000:12700:15500:19:20:21:22:13:14,5:21:Support:10:1/4/15:13000:13500:12500:15:22:13:14:19:3,6:2:Mid:14:8/2/3:20000:12000:16000:2:4:6:8:10:12,7:8:Top:15:4/4/6:19500:12800:15700:14:16:18:20:22:14,8:13:Jungle:12:3/6/10:16800:14300:14500:22:18:13:2:4:6,10:18:Support:11:2/5/14:13500:13900:12600:1:3:5:7:9:11,9:20:Bot:13:6/2/8:18400:12600:15400:8:10:12:14:16:18'
);

SELECT winner_id FROM Tournaments WHERE tournament_name='Summer Cup 2023';
-- winner_id
-- 1

CALL AddMatchToTournament(
    'Summer Cup 2023', 
    '2023-07-16', 
    'Team Liquid', 
    'DWG KIA', 
    'Team Liquid', 
    '00:35:00', 
    '1:1:Mid:12:6/2/4:18500:12500:15000:1:2:3:4:5:6,2:7:Top:13:5/4/7:17500:13000:14800:7:8:9:10:11:12,3:10:Jungle:11:3/5/12:16000:14000:13500:13:14:15:16:17:18,4:15:Bot:11:7/3/9:19000:12700:15500:19:20:21:22:13:14,5:21:Support:10:1/4/15:13000:13500:12500:15:22:13:14:19:3,6:2:Mid:14:8/2/3:20000:12000:16000:2:4:6:8:10:12,7:8:Top:15:4/4/6:19500:12800:15700:14:16:18:20:22:14,8:13:Jungle:12:3/6/10:16800:14300:14500:22:18:13:2:4:6,10:18:Support:11:2/5/14:13500:13900:12600:1:3:5:7:9:11,9:20:Bot:13:6/2/8:18400:12600:15400:8:10:12:14:16:18'
);
SELECT winner_id FROM Tournaments WHERE tournament_name='Summer Cup 2023';
-- winner_id
-- 1

CALL AddMatchToTournament(
    'Summer Cup 2023', 
    '2023-07-17', 
    'Team Liquid', 
    'DWG KIA', 
    'Team Liquid', 
    '00:35:00', 
    '1:1:Mid:12:6/2/4:18500:12500:15000:1:2:3:4:5:6,2:7:Top:13:5/4/7:17500:13000:14800:7:8:9:10:11:12,3:10:Jungle:11:3/5/12:16000:14000:13500:13:14:15:16:17:18,4:15:Bot:11:7/3/9:19000:12700:15500:19:20:21:22:13:14,5:21:Support:10:1/4/15:13000:13500:12500:15:22:13:14:19:3,6:2:Mid:14:8/2/3:20000:12000:16000:2:4:6:8:10:12,7:8:Top:15:4/4/6:19500:12800:15700:14:16:18:20:22:14,8:13:Jungle:12:3/6/10:16800:14300:14500:22:18:13:2:4:6,10:18:Support:11:2/5/14:13500:13900:12600:1:3:5:7:9:11,9:20:Bot:13:6/2/8:18400:12600:15400:8:10:12:14:16:18'
);
SELECT winner_id FROM Tournaments WHERE tournament_name='Summer Cup 2023';
-- winner_id
-- 2

select * from Tournaments;
-- tournament_id   tournament_name winner_id       prize_pool
-- 1       Worlds 2022     1       2000000
-- 2       MSI 2022        1       400000
-- 3       LCS Summer Split 2022   2       50000
-- 4       LCK Spring Split 2022   3       100000
-- 5       Summer Cup 2023 NULL    NULL

select * from Matches;
-- match_id        date_played     winner_id       duration_minutes        tournament_id   team1_id        team2_id
-- 1       2023-01-15      1       25:00:00        1       1       2
-- 2       2023-01-16      2       30:32:00        2       3       4
-- 3       2023-01-16      1       28:12:00        3       2       4
-- 4       2023-01-17      3       22:30:00        4       1       3
-- 5       2023-07-15      1       00:35:00        5       1       2

select * from Picks where match_id=5;
-- pick_id match_id        player_id       champion_id     position        level   statistics      dealt_damage    received_damage earned_gold     item1_id        item2_id        item3_id        item4_id      item5_id        item6_id
-- 11      5       1       1       Mid     12      6/2/4   18500   12500   15000   6       6       6       6       6       6
-- 12      5       2       7       Top     13      5/4/7   17500   13000   14800   12      12      12      12      12      12
-- 13      5       3       10      Jungle  11      3/5/12  16000   14000   13500   18      18      18      18      18      18
-- 14      5       4       15      Bot     11      7/3/9   19000   12700   15500   14      14      14      14      14      14
-- 15      5       5       21      Support 10      1/4/15  13000   13500   12500   3       3       3       3       3       3
-- 16      5       6       2       Mid     14      8/2/3   20000   12000   16000   12      12      12      12      12      12
-- 17      5       7       8       Top     15      4/4/6   19500   12800   15700   14      14      14      14      14      14
-- 18      5       8       13      Jungle  12      3/6/10  16800   14300   14500   6       6       6       6       6       6
-- 19      5       10      18      Support 11      2/5/14  13500   13900   12600   11      11      11      11      11      11
-- 20      5       9       20      Bot     13      6/2/8   18400   12600   15400   18      18      18      18      18      18


SELECT CalculateTeamWinRate('DWG KIA');
SELECT CalculateTeamWinRate('Team Liquid');
-- CalculateTeamWinRate('DWG KIA')
-- 60.00
-- CalculateTeamWinRate('Team Liquid')
-- 60.00



