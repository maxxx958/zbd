USE league;

DROP TABLE IF EXISTS Picks;
DROP TABLE IF EXISTS Champions;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Achievements;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Tournaments;
DROP TABLE IF EXISTS Teams;

CREATE TABLE Teams (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(255) NOT NULL UNIQUE, 
    sponsors VARCHAR(255)
);

CREATE TABLE Tournaments (
    tournament_id INT AUTO_INCREMENT PRIMARY KEY,
    tournament_name VARCHAR(255) NOT NULL UNIQUE,
    winner_id INT,
    prize_pool INT,

    FOREIGN KEY (winner_id) REFERENCES Teams(team_id)
);

CREATE TABLE Matches (
    match_id INT AUTO_INCREMENT PRIMARY KEY,
    date_played DATE NOT NULL,
    winner_id INT NOT NULL,
    duration_minutes TIME NOT NULL,
    tournament_id INT NOT NULL,
    team1_id INT NOT NULL,
    team2_id INT NOT NULL,
    
    FOREIGN KEY (winner_id) REFERENCES Teams(team_id),
    FOREIGN KEY (tournament_id) REFERENCES Tournaments(tournament_id),
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id)
);

CREATE TABLE Players (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    height DECIMAL(5, 2),
    weight DECIMAL(5, 2),
    nickname VARCHAR(255) NOT NULL,
    team_id INT NOT NULL,
    handedness ENUM('Right', 'Left', 'Ambidextrous'),
    birthdate DATE,
    nationality VARCHAR(255),
    date_joined DATE NOT NULL,
    date_left DATE,

    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

CREATE TABLE Achievements (
    achievement_id INT AUTO_INCREMENT PRIMARY KEY,
    kind ENUM('FirstBlood', 'DoubleKill', 'TripleKill', 'QuadraKill', 'PentaKill', 'DragonSteal', 'BaronSteal') NOT NULL,
    in_game_timer TIME NOT NULL,
    match_id INT NOT NULL,
    player_id INT NOT NULL,
    
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);

CREATE TABLE Champions (
    champion_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    difficulty ENUM('Easy', 'Medium', 'Hard') NOT NULL,
    passive_ability_description TEXT NOT NULL,
    ability1_description TEXT NOT NULL,
    ability2_description TEXT NOT NULL,
    ability3_description TEXT NOT NULL,
    ability4_description TEXT NOT NULL
);

CREATE TABLE Items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    description TEXT,
    stats TEXT,
    kind ENUM('Mythic', 'Legendary', 'Epic', 'Basic') NOT NULL
);

CREATE TABLE Picks (
    pick_id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT NOT NULL,
    player_id INT NOT NULL,
    champion_id INT NOT NULL,
    position ENUM('Mid', 'Top', 'Jungle', 'Bot', 'Support') NOT NULL,
    level INT NOT NULL,
    statistics VARCHAR(20) NOT NULL,
    dealt_damage INT NOT NULL,
    received_damage INT NOT NULL,
    earned_gold INT NOT NULL,
    item1_id INT NOT NULL,
    item2_id INT NOT NULL,
    item3_id INT NOT NULL,
    item4_id INT NOT NULL,
    item5_id INT NOT NULL,
    item6_id INT NOT NULL,
    
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id),
    FOREIGN KEY (champion_id) REFERENCES Champions(champion_id),
    FOREIGN KEY (item1_id) REFERENCES Items(item_id),
    FOREIGN KEY (item2_id) REFERENCES Items(item_id),
    FOREIGN KEY (item3_id) REFERENCES Items(item_id),
    FOREIGN KEY (item4_id) REFERENCES Items(item_id),
    FOREIGN KEY (item5_id) REFERENCES Items(item_id),
    FOREIGN KEY (item6_id) REFERENCES Items(item_id)
);


INSERT INTO Teams (team_name)
VALUES
    ('DWG KIA'),
    ('Team Liquid'),
    ('T1'),
    ('G2');

INSERT INTO Tournaments (tournament_name, winner_id, prize_pool)
VALUES
    ('Worlds 2022', 1, 2000000),
    ('MSI 2022', 1, 400000),
    ('LCS Summer Split 2022', 2, 50000),
    ('LCK Spring Split 2022', 3, 100000);

INSERT INTO Matches (date_played, winner_id, duration_minutes, tournament_id, team1_id, team2_id)
VALUES
    ('2023-01-15', 1, '25:00', 1, 1, 2), -- Team 1 vs. Team 2
    ('2023-01-16', 2, '30:32', 2, 3, 4), -- Team 3 vs. Team 4
    ('2023-01-16', 1, '28:12', 3, 2, 4), -- Team 2 vs. Team 4
    ('2023-01-17', 3, '22:30', 4, 1, 3); -- Team 1 vs. Team 3

INSERT INTO Players (first_name, last_name, height, weight, nickname, team_id, handedness, birthdate, nationality, date_joined, date_left)
VALUES
    ('John', 'Doe', 185.5, 80.3, 'Blastmaster', 1, 'Right', '1998-05-15', 'American', '2022-01-15', NULL),
    ('Jane', 'Smith', 175.8, 68.7, 'ShadowStriker', 2, 'Left', '2000-07-22', 'Canadian', '2022-03-10', '2023-04-20'),
    ('Mike', 'Johnson', 190.2, 95.1, 'SteelJuggernaut', 1, 'Right', '1993-12-10', 'British', '2021-12-05', NULL),
    ('Emily', 'Brown', 165.3, 55.5, 'SwiftSerpent', 3, 'Right', '1997-09-28', 'Australian', '2022-02-20', NULL),
    ('Daniel', 'Lee', 175.0, 70.2, 'PhantomBlade', 2, 'Left', '1999-03-14', 'South Korean', '2022-01-05', NULL),
    ('Sophia', 'Garcia', 182.1, 78.8, 'ViperQueen', 4, 'Right', '1996-11-03', 'Mexican', '2022-01-30', NULL),
    ('William', 'Martinez', 187.5, 82.6, 'IronKnight', 3, 'Left', '1995-08-17', 'Spanish', '2022-04-10', NULL),
    ('Olivia', 'Nguyen', 170.9, 64.3, 'StormPhoenix', 1, 'Right', '1998-12-20', 'Vietnamese', '2022-03-05', '2023-05-18'),
    ('Liam', 'Kim', 178.7, 75.0, 'ShadowSword', 4, 'Right', '2001-02-08', 'South Korean', '2022-02-15', NULL),
    ('Ava', 'Patel', 169.2, 62.4, 'InfernoWielder', 2, 'Right', '1997-04-11', 'Indian', '2022-01-02', NULL);

INSERT INTO Achievements (kind, in_game_timer, match_id, player_id)
VALUES
    ('FirstBlood', '10:05', 1, 1),  -- Player 1 achieved First Blood at 10 minutes and 5 seconds in Match 1
    ('DoubleKill', '25:30', 2, 2),  -- Player 2 achieved a Double Kill at 25 minutes and 30 seconds in Match 2
    ('TripleKill', '30:15', 3, 3),  -- Player 3 achieved a Triple Kill at 30 minutes and 15 seconds in Match 3
    ('QuadraKill', '45:20', 4, 4),  -- Player 4 achieved a Quadra Kill at 45 minutes and 20 seconds in Match 4
    ('PentaKill', '58:45', 1, 5),  -- Player 5 achieved a Penta Kill at 58 minutes and 45 seconds in Match 1
    ('DragonSteal', '36:40', 1, 1);  -- Player 1 stole Dragon at 36 minutes and 40 seconds in Match 1

INSERT INTO Champions (name, difficulty, passive_ability_description, ability1_description, ability2_description, ability3_description, ability4_description)
VALUES
    ("Ahri", "Medium", "Essence Theft: Ahri gains a stack of Essence Theft when her spells hit enemies, and she can consume these stacks to heal herself.", "Orb of Deception: Ahri throws her orb, dealing magic damage, and then pulls it back, dealing true damage.", "Fox-Fire: Ahri releases three fox-fires that target and damage nearby enemies.", "Charm: Ahri blows a kiss that damages and charms the first enemy hit.", "Spirit Rush: Ahri dashes and fires essence bolts, which can be reactivated for additional dashes"),
    ("Garen", "Easy", "Perseverance: Garen regenerates health if he has not taken damage for a few seconds.", "Decisive Strike: Garen's next attack deals bonus damage and silences the target.", "Courage: Garen gains a shield and reduces incoming damage for a short duration.", "Judgment: Garen spins around rapidly, damaging nearby enemies.", "Demacian Justice: Garen calls down a sword that deals more damage to enemies with lower health"),
    ("Thresh", "Hard", "Damnation: Thresh collects the souls of dead enemies to gain bonus armor and ability power.", "Death Sentence: Thresh throws his scythe, pulling the first enemy hit toward him.", "Dark Passage: Thresh throws a lantern that allies can click on to be pulled to him.", "Flay: Thresh sweeps his chains in a direction, damaging and pushing enemies.", "The Box: Thresh creates a prison of walls, slowing and damaging enemies who pass through them"),
    ("Darius", "Medium", "Hemorrhage: Darius applies a bleeding effect with his basic attacks and abilities.", "Decimate: Darius swings his axe in a circle, damaging enemies in its path.", "Crippling Strike: Darius's next attack deals bonus damage and slows the target.", "Apprehend: Darius pulls in all enemies in front of him.", "Noxian Guillotine: Darius executes a target, dealing true damage based on the target's missing health"),
    ("Jinx", "Medium", "Get Excited!: Jinx gains movement speed and attack speed when she scores a takedown.", "Switcheroo!: Jinx switches between a minigun and a rocket launcher, with each weapon having different effects.", "Zap!: Jinx fires a zap that slows and damages the first enemy hit.", "Flame Chompers!: Jinx tosses out chompers that root and damage enemies that step on them.", "Super Mega Death Rocket!: Jinx fires a rocket that deals damage to all enemies in its path, with bonus damage to low-health targets"),
    ("Lux", "Easy", "Illumination: Lux's damaging spells mark enemies, and her auto attacks consume the marks for bonus damage.", "Light Binding: Lux releases a sphere of light that immobilizes and damages the first two enemies hit.", "Prismatic Barrier: Lux throws her wand in a line, shielding and damaging enemies twice.", "Lucent Singularity: Lux sends an anomaly of light that slows and damages enemies.", "Final Spark: Lux fires a giant laser that damages all enemies in a line, dealing bonus damage to enemies closer to the center"),
    ("Zed", "Hard", "Contempt for the Weak: Zed's basic attacks against targets below a certain health percentage deal bonus magic damage.", "Razor Shuriken: Zed throws his shuriken in a line, damaging enemies in its path.", "Living Shadow: Zed can swap places with his shadow, which mimics his abilities.", "Shadow Slash: Zed spins and damages enemies in a radius.", "Death Mark: Zed marks a target for death, then he can trigger the mark to deal bonus damage"),
    ("Caitlyn", "Easy", "Headshot: Caitlyn's basic attacks periodically deal bonus damage.", "Piltover Peacemaker: Caitlyn fires a long-range shot that damages all enemies in its path.", "Yordle Snap Trap: Caitlyn sets a trap that immobilizes and damages enemies when triggered.", "90 Caliber Net: Caitlyn fires a net that slows and knocks her back.", "Ace in the Hole: Caitlyn locks onto an enemy and fires a high-damage shot at long range"),
    ("Ekko", "Medium", "Z-Drive Resonance: Ekko's basic attacks and spells apply a stack that, when triggered, damages and slows the target.", "Timewinder: Ekko throws a device that damages and returns to him, damaging enemies again.", "Parallel Convergence: Ekko creates a field that stuns and damages enemies caught inside.", "Phase Dive: Ekko dashes to a location, damaging and blinking to a nearby target.", "Chronobreak: Ekko enters stasis and then returns to a previous location, damaging enemies near his arrival point"),
    ("Yasuo", "Hard", "Way of the Wanderer: Yasuo has a passive shield that can block incoming damage. When charged, he gains critical strike chance.", "Steel Tempest: Yasuo thrusts his sword, damaging enemies and gathering stacks for a tornado.", "Wind Wall: Yasuo creates a wall that blocks enemy projectiles.", "Sweeping Blade: Yasuo dashes through targets, dealing damage. He can stack dashes for mobility.", "Last Breath: Yasuo blinks to a target and suspends them, while dealing damage and gaining armor penetration"),
    ("Katarina", "Hard", "Voracity: Katarina's passive reduces her ability cooldowns upon getting takedowns or assists.", "Bouncing Blade: Katarina throws a dagger that bounces to multiple targets, dealing damage.", "Shunpo: Katarina teleports to a target, dealing damage. She can use it for mobility.", "Sinister Steel: Katarina spins and damages all nearby enemies.", "Death Lotus: Katarina channels, throwing daggers at multiple targets for heavy damage"),
    ("Vi", "Medium", "Blast Shield: Vi's passive shield activates when she uses her abilities.", "Vault Breaker: Vi charges her punch, releasing it to damage and knock up the first enemy hit.", "Denting Blows: Vi's auto attacks apply stacks that can be consumed to shatter the target's armor.", "Excessive Force: Vi empowers her next auto attack, dealing bonus damage.", "Assault and Battery: Vi targets an enemy, charging to them and damaging them while knocking aside enemies in her path."),
    ("Yone", "Medium", "Way of the Hunter: Yone's passive empowers his first attack after casting a spell.", "Mortal Steel: Yone slashes with his sword, dealing damage in a line.", "Spirit Cleave: Yone slashes forward, damaging enemies and gaining a shield.", "Soul Unbound: Yone becomes untargetable and can reposition. On reactivation, he dashes to a target and damages enemies.", "Sealed Fate: Yone releases a wave of energy, damaging enemies in a cone."),
    ("Seraphine", "Easy", "Stage Presence: Seraphine's abilities apply Echo, which affects her basic attacks.", "High Note: Seraphine fires a soundwave that damages and slows the first enemy hit.", "Surround Sound: Seraphine shields herself and allies in a cone, healing herself and allies outside the cone.", "Encore: Seraphine releases a shockwave that damages and charms enemies.", "Beat Drop: Seraphine can cast her Echo-powered abilities, granting her bonus magic damage on her next few basic attacks."),
    ("Sett", "Medium", "Pit Grit: Sett gains bonus health regeneration when low on health.", "Knuckle Down: Sett empowers his next two basic attacks, dealing bonus damage.", "Haymaker: Sett charges up a punch that damages enemies in a cone.", "Facebreaker: Sett grabs enemies on either side of him and slams them together.", "The Show Stopper: Sett targets an enemy and suplexes them, dealing damage to enemies on landing."),
    ("Ashe", "Easy", "Frost Shot: Ashe's basic attacks slow enemies.", "Ranger's Focus: Ashe empowers her next basic attack, which also critically strikes.", "Volley: Ashe fires a volley of arrows that damages and slows enemies.", "Hawkshot: Ashe sends her hawk to scout an area and gain vision.", "Enchanted Crystal Arrow: Ashe fires an arrow that stuns and damages the first enemy hit, with the stun duration increasing with distance traveled."),
    ("Nami", "Medium", "Surging Tides: Nami's abilities empower her basic attacks and speed up allies.", "Aqua Prison: Nami sends a bubble that stuns and damages the first enemy hit.", "Ebb and Flow: Nami releases a stream of water that damages enemies, then bounces to heal allies.", "Tidecaller's Blessing: Nami enhances an ally's basic attack with bonus damage and a slow.", "Tidal Wave: Nami sends a massive wave that knocks up and damages enemies."),
    ("Warwick", "Easy", "Eternal Hunger: Warwick's basic attacks deal bonus magic damage and heal him.", "Jaws of the Beast: Warwick dashes to a target, damaging and healing with the ability.", "Blood Hunt: Warwick gains bonus attack speed and movement speed when an enemy is below a certain health percentage.", "Primal Howl: Warwick gains damage reduction and fears nearby enemies with a howl.", "Infinite Duress: Warwick suppresses and damages a target, healing himself with each attack."),
    ("Syndra", "Hard", "Transcendent: Syndra's passive increases the max rank of her abilities.", "Dark Sphere: Syndra places a dark sphere on the ground, which she can then throw at enemies for damage.", "Force of Will: Syndra grabs a dark sphere and enemies, dealing damage and slowing them.", "Scatter the Weak: Syndra knocks back and stuns enemies with a targeted dark sphere.", "Unleashed Power: Syndra unleashes her dark spheres, damaging all enemies hit."),
    ("Nautilus", "Easy", "Staggering Blow: Nautilus's basic attacks deal bonus damage and root the target.", "Dredge Line: Nautilus hurls his anchor at a location, damaging and pulling himself to the target.", "Titan's Wrath: Nautilus gains a shield and damages enemies around him.", "Riptide: Nautilus damages and slows enemies in a circle around him.", "Depth Charge: Nautilus launches a depth charge that damages and knocks up the first enemy hit, creating a shockwave."),
    ("Samira", "Hard", "Daredevil Impulse: Samira builds a combo by chaining different abilities.", "Flair: Samira slashes in a circle, damaging and lifestealing from enemies.", "Defiant Dance: Samira blocks incoming projectiles and gains style when hitting enemies.", "Wild Rush: Samira dashes to a target, damaging and attacking enemies in her path.", "Inferno Trigger: Samira unleashes a flurry of shots, damaging and knocking up enemies in her vicinity."),
    ("Kha'Zix", "Medium", "Unseen Threat: Kha'Zix's basic attacks and isolated Q damage apply Unseen Threat, which can be triggered for bonus damage.", "Taste Their Fear: Kha'Zix slashes the target with his claws, dealing bonus damage to isolated targets.", "Void Spike: Kha'Zix fires spikes that damage and slow the first enemy hit.", "Leap: Kha'Zix jumps to a target location.", "Void Assault: Kha'Zix evolves his abilities, gains stealth, and deals bonus damage with his next basic attack."),
    ("Sylas", "Hard", "Petricite Burst: Sylas's basic attacks charge up and deal bonus magic damage.", "Chain Lash: Sylas lashes out with his chains, damaging and pulling himself to the target.", "Kingslayer: Sylas targets an enemy, dealing damage and healing based on the enemy's missing health.", "Abscond: Sylas dashes to a location and creates a clone.", "Hijack: Sylas steals the ultimates of nearby enemies, gaining their abilities for his next cast."),
    ("Fiora", "Hard", "Duelist's Dance: Fiora identifies the weak spot of enemy champions, gaining movement speed towards them.", "Lunge: Fiora lunges forward to stab her target, dealing damage.", "Riposte: Fiora parries the next immobilizing effect and damages the enemy.", "Bladework: Fiora targets an enemy, performing two quick strikes with bonus damage.", "Grand Challenge: Fiora reveals all four Vitals on an enemy champion, gaining bonus movement speed and healing from hitting them."),
    ("Sona", "Easy", "Power Chord: Sona's basic attacks after casting spells deal bonus magic damage.", "Hymn of Valor: Sona sends out two bolts of sound, damaging enemies and empowering her basic attacks.", "Aria of Perseverance: Sona heals herself and allies, also granting bonus shielding when powered up.", "Song of Celerity: Sona gains bonus movement speed and can empower her basic attacks.", "Crescendo: Sona releases a shockwave that stuns enemies hit and damages them.");

INSERT INTO Items (name, price, description, stats, kind)
VALUES
    ("Infinity Edge", 3400, "Massively increases critical strike damage.", "Attack Damage +80, Critical Strike +25%", "Legendary"),
    ("Thornmail", 2900, "Reflects a percentage of damage taken from basic attacks.", "Armor +60, Unique Passive: Thorns - Upon being hit by a basic attack, reflects magic damage equal to 25% of your bonus armor.", "Legendary"),
    ("The Bloodthirster", 3400, "Gives lifesteal and a shield when you're low on health.", "Attack Damage +55, Life Steal +20%, Unique Passive: Bloodthirst - Grants a shield that can absorb damage.", "Legendary"),
    ("Ravenous Hydra", 3300, "Empowers basic attacks and abilities with a splash damage effect.", "Attack Damage +80, Life Steal +15%, Unique Passive: Cleave - Basic attacks deal 60% to 100% of total Attack Damage as bonus physical damage to enemies near the target.", "Legendary"),
    ("Essence Reaver", 2900, "Gives cooldown reduction and mana restoration on critical strikes.", "Attack Damage +55, Critical Strike +20%, Cooldown Reduction +20%, Unique Passive: Essence Flare - After using an ultimate ability, your next basic attack within 10 seconds grants Essence Flare.", "Legendary"),
    ("Sunfire Aegis", 3200, "Deals persistent area damage to nearby enemies.", "Health +450, Armor +30, Magic Resist +30, Ability Haste +15, Unique Passive: Immolate - Deal persistent damage to nearby enemies.", "Mythic"),
    ("Galeforce", 3400, "Dash and strike your target, granting bonus movement speed.", "Attack Damage +60, Attack Speed +20%, Critical Strike +20%, Unique Passive: Dealing damage grants you a stack of Giant Slayer.", "Mythic"),
    ("Black Cleaver", 3300, "Shreds enemy armor and grants movement speed.", "Attack Damage +40, Health +400, Ability Haste +20, Unique Passive: Dealing physical damage to an enemy champion reduces their Armor by 4% for 6 seconds.", "Legendary"),
    ("Divine Sunderer", 3300, "Deals bonus damage and heals you on ability use.", "Attack Damage +40, Health +400, Attack Speed +20%, Ability Haste +20, Unique Passive: Spellblade - After using an ability, your next basic attack deals bonus damage.", "Legendary"),
    ("Hextech Rocketbelt", 3200, "Dash forward and unleash a shockwave.", "Ability Power +80, Health +250, Ability Haste +15, Unique Active: Dash in target direction, unleashing a shockwave that damages enemies.", "Mythic"),
    ("Liandry's Anguish", 3200, "Burns enemies for damage over time and empowers abilities.", "Ability Power +80, Health +300, Ability Haste +15, Unique Passive: Madness - Dealing damage to champions below 15% health deals bonus damage.", "Mythic"),
    ("Abyssal Mask", 3200, "Amplifies magic damage and grants bonus health and mana.", "Health +350, Magic Resist +60, Ability Haste +10, Unique Passive: Eternity - Grants a refund of a portion of your Ability Haste on takedowns.", "Mythic"),
    ("Dead Man's Plate", 2900, "Gains momentum as you move, then hits and slows your target.", "Health +300, Armor +50, Unique Passive: Dreadnought - Build momentum as you move, then hit your target to deal bonus damage and slow them.", "Legendary"),
    ("Quicksilver Sash", 1300, "Removes all crowd control effects.", "Ability Power +30, Active: Removes all crowd control effects.", "Legendary"),
    ("Boots of Swiftness", 1000, "Enhances your movement speed.", "Unique Passive: Enhanced Movement - Grants increased movement speed.", "Basic"),
    ("Sorcerer's Shoes", 1100, "Enhances your magic penetration and movement speed.", "Ability Power +18, Unique Passive: Enhanced Movement - Grants increased movement speed.", "Basic"),
    ("Ionian Boots of Lucidity", 950, "Enhances your cooldown reduction and movement speed.", "Ability Haste +20, Unique Passive: Enhanced Movement - Grants increased movement speed.", "Basic"),
    ("Berserker Greaves", 1100, "Enhances your attack speed and movement speed.", "Attack Speed +35%, Unique Passive: Enhanced Movement - Grants increased movement speed.", "Basic"),
    ("Ninja Tabi", 1100, "Enhances your armor and movement speed.", "Armor +20, Unique Passive: Enhanced Movement - Grants increased movement speed.", "Basic"),
    ("Mercury's Treads", 1100, "Enhances your magic resist and movement speed.", "Magic Resist +25, Unique Passive: Enhanced Movement - Grants increased movement speed.", "Basic"),
    ("Frostfire Gauntlet", 2800, "Slows and damages nearby enemies.", "Health +350, Armor +50, Magic Resist +25, Unique Passive: Icy - Basic attacks create a frost field that slows enemies.", "Mythic"),
    ("Luden's Tempest", 3200, "Empowers your abilities and grants bonus movement speed.", "Ability Power +80, Magic Penetration +10, Ability Haste +10, Unique Passive: Echo - Empowers your damaging abilities.", "Mythic");

INSERT INTO Picks (match_id, player_id, champion_id, position, level, statistics, dealt_damage, received_damage, earned_gold, item1_id, item2_id, item3_id, item4_id, item5_id, item6_id)
VALUES
    (1, 1, 1, 'Mid', 12, '6/2/4', 18500, 12500, 15000, 1, 2, 3, 4, 5, 6),
    (1, 2, 7, 'Top', 13, '5/4/7', 17500, 13000, 14800, 7, 8, 9, 10, 11, 12),
    (1, 3, 10, 'Jungle', 11, '3/5/12', 16000, 14000, 13500, 13, 14, 15, 16, 17, 18),
    (1, 4, 15, 'Bot', 11, '7/3/9', 19000, 12700, 15500, 19, 20, 21, 22, 13, 14),
    (1, 5, 21, 'Support', 10, '1/4/15', 13000, 13500, 12500, 15, 22, 13, 14, 19, 3),
    (2, 6, 2, 'Mid', 14, '8/2/3', 20000, 12000, 16000, 2, 4, 6, 8, 10, 12),
    (2, 7, 8, 'Top', 15, '4/4/6', 19500, 12800, 15700, 14, 16, 18, 20, 22, 14),
    (2, 8, 13, 'Jungle', 12, '3/6/10', 16800, 14300, 14500, 22, 18, 13, 2, 4, 6),
    (2, 9, 20, 'Bot', 13, '6/2/8', 18400, 12600, 15400, 8, 10, 12, 14, 16, 18),
    (2, 10, 18, 'Support', 11, '2/5/14', 13500, 13900, 12600, 1, 3, 5, 7, 9, 11);



SELECT * FROM Teams;
SELECT * FROM Tournaments;
SELECT * FROM Matches;
SELECT * FROM Players;
SELECT * FROM Achievements;
SELECT * FROM Champions;
SELECT * FROM Items;
SELECT * FROM Picks;
