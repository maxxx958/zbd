-- MariaDB dump 10.19-11.1.3-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: league
-- ------------------------------------------------------
-- Server version	11.1.3-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE="+00:00" */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Achievements`
--

DROP TABLE IF EXISTS `Achievements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Achievements` (
  `achievement_id` int(11) NOT NULL AUTO_INCREMENT,
  `kind` enum("FirstBlood","DoubleKill","TripleKill","QuadraKill","PentaKill","DragonSteal","BaronSteal") NOT NULL,
  `in_game_timer` time NOT NULL,
  `match_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  PRIMARY KEY (`achievement_id`),
  KEY `match_id` (`match_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `Achievements_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `Matches` (`match_id`),
  CONSTRAINT `Achievements_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `Players` (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Achievements`
--

LOCK TABLES `Achievements` WRITE;
/*!40000 ALTER TABLE `Achievements` DISABLE KEYS */;
INSERT INTO `Achievements` VALUES
(1,"FirstBlood","10:05:00",1,1),
(2,"DoubleKill","25:30:00",2,2),
(3,"TripleKill","30:15:00",3,3),
(4,"QuadraKill","45:20:00",4,4),
(5,"PentaKill","58:45:00",1,5),
(6,"DragonSteal","36:40:00",1,1);
/*!40000 ALTER TABLE `Achievements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `ChampionStatistics`
--

DROP TABLE IF EXISTS `ChampionStatistics`;
/*!50001 DROP VIEW IF EXISTS `ChampionStatistics`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `ChampionStatistics` AS SELECT
 1 AS `champion_id`,
  1 AS `champion_name`,
  1 AS `champion_difficulty`,
  1 AS `total_picks`,
  1 AS `total_dealt_damage`,
  1 AS `average_dealt_damage`,
  1 AS `total_received_damage`,
  1 AS `average_received_damage`,
  1 AS `total_earned_gold`,
  1 AS `average_earned_gold` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Champions`
--

DROP TABLE IF EXISTS `Champions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Champions` (
  `champion_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `difficulty` enum("Easy","Medium","Hard") NOT NULL,
  `passive_ability_description` text NOT NULL,
  `ability1_description` text NOT NULL,
  `ability2_description` text NOT NULL,
  `ability3_description` text NOT NULL,
  `ability4_description` text NOT NULL,
  PRIMARY KEY (`champion_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Champions`
--

LOCK TABLES `Champions` WRITE;
/*!40000 ALTER TABLE `Champions` DISABLE KEYS */;
INSERT INTO `Champions` VALUES
(1,"Ahri","Medium","Essence Theft: Ahri gains a stack of Essence Theft when her spells hit enemies, and she can consume these stacks to heal herself.","Orb of Deception: Ahri throws her orb, dealing magic damage, and then pulls it back, dealing true damage.","Fox-Fire: Ahri releases three fox-fires that target and damage nearby enemies.","Charm: Ahri blows a kiss that damages and charms the first enemy hit.","Spirit Rush: Ahri dashes and fires essence bolts, which can be reactivated for additional dashes"),
(2,"Garen","Easy","Perseverance: Garen regenerates health if he has not taken damage for a few seconds.","Decisive Strike: Garen's next attack deals bonus damage and silences the target.","Courage: Garen gains a shield and reduces incoming damage for a short duration.","Judgment: Garen spins around rapidly, damaging nearby enemies.","Demacian Justice: Garen calls down a sword that deals more damage to enemies with lower health"),
(3,"Thresh","Hard","Damnation: Thresh collects the souls of dead enemies to gain bonus armor and ability power.","Death Sentence: Thresh throws his scythe, pulling the first enemy hit toward him.","Dark Passage: Thresh throws a lantern that allies can click on to be pulled to him.","Flay: Thresh sweeps his chains in a direction, damaging and pushing enemies.","The Box: Thresh creates a prison of walls, slowing and damaging enemies who pass through them"),
(4,"Darius","Medium","Hemorrhage: Darius applies a bleeding effect with his basic attacks and abilities.","Decimate: Darius swings his axe in a circle, damaging enemies in its path.","Crippling Strike: Darius's next attack deals bonus damage and slows the target.","Apprehend: Darius pulls in all enemies in front of him.","Noxian Guillotine: Darius executes a target, dealing true damage based on the target's missing health"),
(5,"Jinx","Medium","Get Excited!: Jinx gains movement speed and attack speed when she scores a takedown.","Switcheroo!: Jinx switches between a minigun and a rocket launcher, with each weapon having different effects.","Zap!: Jinx fires a zap that slows and damages the first enemy hit.","Flame Chompers!: Jinx tosses out chompers that root and damage enemies that step on them.","Super Mega Death Rocket!: Jinx fires a rocket that deals damage to all enemies in its path, with bonus damage to low-health targets"),
(6,"Lux","Easy","Illumination: Lux's damaging spells mark enemies, and her auto attacks consume the marks for bonus damage.","Light Binding: Lux releases a sphere of light that immobilizes and damages the first two enemies hit.","Prismatic Barrier: Lux throws her wand in a line, shielding and damaging enemies twice.","Lucent Singularity: Lux sends an anomaly of light that slows and damages enemies.","Final Spark: Lux fires a giant laser that damages all enemies in a line, dealing bonus damage to enemies closer to the center"),
(7,"Zed","Hard","Contempt for the Weak: Zed's basic attacks against targets below a certain health percentage deal bonus magic damage.","Razor Shuriken: Zed throws his shuriken in a line, damaging enemies in its path.","Living Shadow: Zed can swap places with his shadow, which mimics his abilities.","Shadow Slash: Zed spins and damages enemies in a radius.","Death Mark: Zed marks a target for death, then he can trigger the mark to deal bonus damage"),
(8,"Caitlyn","Easy","Headshot: Caitlyn's basic attacks periodically deal bonus damage.","Piltover Peacemaker: Caitlyn fires a long-range shot that damages all enemies in its path.","Yordle Snap Trap: Caitlyn sets a trap that immobilizes and damages enemies when triggered.","90 Caliber Net: Caitlyn fires a net that slows and knocks her back.","Ace in the Hole: Caitlyn locks onto an enemy and fires a high-damage shot at long range"),
(9,"Ekko","Medium","Z-Drive Resonance: Ekko's basic attacks and spells apply a stack that, when triggered, damages and slows the target.","Timewinder: Ekko throws a device that damages and returns to him, damaging enemies again.","Parallel Convergence: Ekko creates a field that stuns and damages enemies caught inside.","Phase Dive: Ekko dashes to a location, damaging and blinking to a nearby target.","Chronobreak: Ekko enters stasis and then returns to a previous location, damaging enemies near his arrival point"),
(10,"Yasuo","Hard","Way of the Wanderer: Yasuo has a passive shield that can block incoming damage. When charged, he gains critical strike chance.","Steel Tempest: Yasuo thrusts his sword, damaging enemies and gathering stacks for a tornado.","Wind Wall: Yasuo creates a wall that blocks enemy projectiles.","Sweeping Blade: Yasuo dashes through targets, dealing damage. He can stack dashes for mobility.","Last Breath: Yasuo blinks to a target and suspends them, while dealing damage and gaining armor penetration"),
(11,"Katarina","Hard","Voracity: Katarina's passive reduces her ability cooldowns upon getting takedowns or assists.","Bouncing Blade: Katarina throws a dagger that bounces to multiple targets, dealing damage.","Shunpo: Katarina teleports to a target, dealing damage. She can use it for mobility.","Sinister Steel: Katarina spins and damages all nearby enemies.","Death Lotus: Katarina channels, throwing daggers at multiple targets for heavy damage"),
(12,"Vi","Medium","Blast Shield: Vi's passive shield activates when she uses her abilities.","Vault Breaker: Vi charges her punch, releasing it to damage and knock up the first enemy hit.","Denting Blows: Vi's auto attacks apply stacks that can be consumed to shatter the target's armor.","Excessive Force: Vi empowers her next auto attack, dealing bonus damage.","Assault and Battery: Vi targets an enemy, charging to them and damaging them while knocking aside enemies in her path."),
(13,"Yone","Medium","Way of the Hunter: Yone's passive empowers his first attack after casting a spell.","Mortal Steel: Yone slashes with his sword, dealing damage in a line.","Spirit Cleave: Yone slashes forward, damaging enemies and gaining a shield.","Soul Unbound: Yone becomes untargetable and can reposition. On reactivation, he dashes to a target and damages enemies.","Sealed Fate: Yone releases a wave of energy, damaging enemies in a cone."),
(14,"Seraphine","Easy","Stage Presence: Seraphine's abilities apply Echo, which affects her basic attacks.","High Note: Seraphine fires a soundwave that damages and slows the first enemy hit.","Surround Sound: Seraphine shields herself and allies in a cone, healing herself and allies outside the cone.","Encore: Seraphine releases a shockwave that damages and charms enemies.","Beat Drop: Seraphine can cast her Echo-powered abilities, granting her bonus magic damage on her next few basic attacks."),
(15,"Sett","Medium","Pit Grit: Sett gains bonus health regeneration when low on health.","Knuckle Down: Sett empowers his next two basic attacks, dealing bonus damage.","Haymaker: Sett charges up a punch that damages enemies in a cone.","Facebreaker: Sett grabs enemies on either side of him and slams them together.","The Show Stopper: Sett targets an enemy and suplexes them, dealing damage to enemies on landing."),
(16,"Ashe","Easy","Frost Shot: Ashe's basic attacks slow enemies.","Ranger's Focus: Ashe empowers her next basic attack, which also critically strikes.","Volley: Ashe fires a volley of arrows that damages and slows enemies.","Hawkshot: Ashe sends her hawk to scout an area and gain vision.","Enchanted Crystal Arrow: Ashe fires an arrow that stuns and damages the first enemy hit, with the stun duration increasing with distance traveled."),
(17,"Nami","Medium","Surging Tides: Nami's abilities empower her basic attacks and speed up allies.","Aqua Prison: Nami sends a bubble that stuns and damages the first enemy hit.","Ebb and Flow: Nami releases a stream of water that damages enemies, then bounces to heal allies.","Tidecaller's Blessing: Nami enhances an ally's basic attack with bonus damage and a slow.","Tidal Wave: Nami sends a massive wave that knocks up and damages enemies."),
(18,"Warwick","Easy","Eternal Hunger: Warwick's basic attacks deal bonus magic damage and heal him.","Jaws of the Beast: Warwick dashes to a target, damaging and healing with the ability.","Blood Hunt: Warwick gains bonus attack speed and movement speed when an enemy is below a certain health percentage.","Primal Howl: Warwick gains damage reduction and fears nearby enemies with a howl.","Infinite Duress: Warwick suppresses and damages a target, healing himself with each attack."),
(19,"Syndra","Hard","Transcendent: Syndra's passive increases the max rank of her abilities.","Dark Sphere: Syndra places a dark sphere on the ground, which she can then throw at enemies for damage.","Force of Will: Syndra grabs a dark sphere and enemies, dealing damage and slowing them.","Scatter the Weak: Syndra knocks back and stuns enemies with a targeted dark sphere.","Unleashed Power: Syndra unleashes her dark spheres, damaging all enemies hit."),
(20,"Nautilus","Easy","Staggering Blow: Nautilus's basic attacks deal bonus damage and root the target.","Dredge Line: Nautilus hurls his anchor at a location, damaging and pulling himself to the target.","Titan's Wrath: Nautilus gains a shield and damages enemies around him.","Riptide: Nautilus damages and slows enemies in a circle around him.","Depth Charge: Nautilus launches a depth charge that damages and knocks up the first enemy hit, creating a shockwave."),
(21,"Samira","Hard","Daredevil Impulse: Samira builds a combo by chaining different abilities.","Flair: Samira slashes in a circle, damaging and lifestealing from enemies.","Defiant Dance: Samira blocks incoming projectiles and gains style when hitting enemies.","Wild Rush: Samira dashes to a target, damaging and attacking enemies in her path.","Inferno Trigger: Samira unleashes a flurry of shots, damaging and knocking up enemies in her vicinity."),
(22,"Kha'Zix","Medium","Unseen Threat: Kha'Zix's basic attacks and isolated Q damage apply Unseen Threat, which can be triggered for bonus damage.","Taste Their Fear: Kha'Zix slashes the target with his claws, dealing bonus damage to isolated targets.","Void Spike: Kha'Zix fires spikes that damage and slow the first enemy hit.","Leap: Kha'Zix jumps to a target location.","Void Assault: Kha'Zix evolves his abilities, gains stealth, and deals bonus damage with his next basic attack."),
(23,"Sylas","Hard","Petricite Burst: Sylas's basic attacks charge up and deal bonus magic damage.","Chain Lash: Sylas lashes out with his chains, damaging and pulling himself to the target.","Kingslayer: Sylas targets an enemy, dealing damage and healing based on the enemy's missing health.","Abscond: Sylas dashes to a location and creates a clone.","Hijack: Sylas steals the ultimates of nearby enemies, gaining their abilities for his next cast."),
(24,"Fiora","Hard","Duelist's Dance: Fiora identifies the weak spot of enemy champions, gaining movement speed towards them.","Lunge: Fiora lunges forward to stab her target, dealing damage.","Riposte: Fiora parries the next immobilizing effect and damages the enemy.","Bladework: Fiora targets an enemy, performing two quick strikes with bonus damage.","Grand Challenge: Fiora reveals all four Vitals on an enemy champion, gaining bonus movement speed and healing from hitting them."),
(25,"Sona","Easy","Power Chord: Sona's basic attacks after casting spells deal bonus magic damage.","Hymn of Valor: Sona sends out two bolts of sound, damaging enemies and empowering her basic attacks.","Aria of Perseverance: Sona heals herself and allies, also granting bonus shielding when powered up.","Song of Celerity: Sona gains bonus movement speed and can empower her basic attacks.","Crescendo: Sona releases a shockwave that stuns enemies hit and damages them.");
/*!40000 ALTER TABLE `Champions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Items`
--

DROP TABLE IF EXISTS `Items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `price` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `stats` text DEFAULT NULL,
  `kind` enum("Mythic","Legendary","Epic","Basic") NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Items`
--

LOCK TABLES `Items` WRITE;
/*!40000 ALTER TABLE `Items` DISABLE KEYS */;
INSERT INTO `Items` VALUES
(1,"Infinity Edge",3400,"Massively increases critical strike damage.","Attack Damage +80, Critical Strike +25%","Legendary"),
(2,"Thornmail",2900,"Reflects a percentage of damage taken from basic attacks.","Armor +60, Unique Passive: Thorns - Upon being hit by a basic attack, reflects magic damage equal to 25% of your bonus armor.","Legendary"),
(3,"The Bloodthirster",3400,"Gives lifesteal and a shield when you're low on health.","Attack Damage +55, Life Steal +20%, Unique Passive: Bloodthirst - Grants a shield that can absorb damage.","Legendary"),
(4,"Ravenous Hydra",3300,"Empowers basic attacks and abilities with a splash damage effect.","Attack Damage +80, Life Steal +15%, Unique Passive: Cleave - Basic attacks deal 60% to 100% of total Attack Damage as bonus physical damage to enemies near the target.","Legendary"),
(5,"Essence Reaver",2900,"Gives cooldown reduction and mana restoration on critical strikes.","Attack Damage +55, Critical Strike +20%, Cooldown Reduction +20%, Unique Passive: Essence Flare - After using an ultimate ability, your next basic attack within 10 seconds grants Essence Flare.","Legendary"),
(6,"Sunfire Aegis",3200,"Deals persistent area damage to nearby enemies.","Health +450, Armor +30, Magic Resist +30, Ability Haste +15, Unique Passive: Immolate - Deal persistent damage to nearby enemies.","Mythic"),
(7,"Galeforce",3400,"Dash and strike your target, granting bonus movement speed.","Attack Damage +60, Attack Speed +20%, Critical Strike +20%, Unique Passive: Dealing damage grants you a stack of Giant Slayer.","Mythic"),
(8,"Black Cleaver",3300,"Shreds enemy armor and grants movement speed.","Attack Damage +40, Health +400, Ability Haste +20, Unique Passive: Dealing physical damage to an enemy champion reduces their Armor by 4% for 6 seconds.","Legendary"),
(9,"Divine Sunderer",3300,"Deals bonus damage and heals you on ability use.","Attack Damage +40, Health +400, Attack Speed +20%, Ability Haste +20, Unique Passive: Spellblade - After using an ability, your next basic attack deals bonus damage.","Legendary"),
(10,"Hextech Rocketbelt",3200,"Dash forward and unleash a shockwave.","Ability Power +80, Health +250, Ability Haste +15, Unique Active: Dash in target direction, unleashing a shockwave that damages enemies.","Mythic"),
(11,"Liandry's Anguish",3200,"Burns enemies for damage over time and empowers abilities.","Ability Power +80, Health +300, Ability Haste +15, Unique Passive: Madness - Dealing damage to champions below 15% health deals bonus damage.","Mythic"),
(12,"Abyssal Mask",3200,"Amplifies magic damage and grants bonus health and mana.","Health +350, Magic Resist +60, Ability Haste +10, Unique Passive: Eternity - Grants a refund of a portion of your Ability Haste on takedowns.","Mythic"),
(13,"Dead Man's Plate",2900,"Gains momentum as you move, then hits and slows your target.","Health +300, Armor +50, Unique Passive: Dreadnought - Build momentum as you move, then hit your target to deal bonus damage and slow them.","Legendary"),
(14,"Quicksilver Sash",1300,"Removes all crowd control effects.","Ability Power +30, Active: Removes all crowd control effects.","Legendary"),
(15,"Boots of Swiftness",1000,"Enhances your movement speed.","Unique Passive: Enhanced Movement - Grants increased movement speed.","Basic"),
(16,"Sorcerer's Shoes",1100,"Enhances your magic penetration and movement speed.","Ability Power +18, Unique Passive: Enhanced Movement - Grants increased movement speed.","Basic"),
(17,"Ionian Boots of Lucidity",950,"Enhances your cooldown reduction and movement speed.","Ability Haste +20, Unique Passive: Enhanced Movement - Grants increased movement speed.","Basic"),
(18,"Berserker Greaves",1100,"Enhances your attack speed and movement speed.","Attack Speed +35%, Unique Passive: Enhanced Movement - Grants increased movement speed.","Basic"),
(19,"Ninja Tabi",1100,"Enhances your armor and movement speed.","Armor +20, Unique Passive: Enhanced Movement - Grants increased movement speed.","Basic"),
(20,"Mercury's Treads",1100,"Enhances your magic resist and movement speed.","Magic Resist +25, Unique Passive: Enhanced Movement - Grants increased movement speed.","Basic"),
(21,"Frostfire Gauntlet",2800,"Slows and damages nearby enemies.","Health +350, Armor +50, Magic Resist +25, Unique Passive: Icy - Basic attacks create a frost field that slows enemies.","Mythic"),
(22,"Luden's Tempest",3200,"Empowers your abilities and grants bonus movement speed.","Ability Power +80, Magic Penetration +10, Ability Haste +10, Unique Passive: Echo - Empowers your damaging abilities.","Mythic");
/*!40000 ALTER TABLE `Items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Matches`
--

DROP TABLE IF EXISTS `Matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Matches` (
  `match_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_played` date NOT NULL,
  `winner_id` int(11) NOT NULL,
  `duration_minutes` time NOT NULL,
  `tournament_id` int(11) NOT NULL,
  `team1_id` int(11) NOT NULL,
  `team2_id` int(11) NOT NULL,
  PRIMARY KEY (`match_id`),
  KEY `winner_id` (`winner_id`),
  KEY `tournament_id` (`tournament_id`),
  KEY `team1_id` (`team1_id`),
  KEY `team2_id` (`team2_id`),
  KEY `idx_date_played` (`date_played`),
  CONSTRAINT `Matches_ibfk_1` FOREIGN KEY (`winner_id`) REFERENCES `Teams` (`team_id`),
  CONSTRAINT `Matches_ibfk_2` FOREIGN KEY (`tournament_id`) REFERENCES `Tournaments` (`tournament_id`),
  CONSTRAINT `Matches_ibfk_3` FOREIGN KEY (`team1_id`) REFERENCES `Teams` (`team_id`),
  CONSTRAINT `Matches_ibfk_4` FOREIGN KEY (`team2_id`) REFERENCES `Teams` (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Matches`
--

LOCK TABLES `Matches` WRITE;
/*!40000 ALTER TABLE `Matches` DISABLE KEYS */;
INSERT INTO `Matches` VALUES
(1,"2023-01-15",1,"25:00:00",1,1,2),
(2,"2023-01-16",2,"30:32:00",2,3,4),
(3,"2023-01-16",1,"28:12:00",3,2,4),
(4,"2023-01-17",3,"22:30:00",4,1,3),
(5,"2023-07-15",1,"00:35:00",5,1,2),
(6,"2023-07-16",2,"00:35:00",5,1,2),
(7,"2023-07-17",2,"00:35:00",5,1,2);
/*!40000 ALTER TABLE `Matches` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = "STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER UpdateTournamentWinner AFTER INSERT ON Matches
FOR EACH ROW
BEGIN
    DECLARE v_tournament_name VARCHAR(30);
    SELECT tournament_name into v_tournament_name from Tournaments where tournament_id = NEW.tournament_id;
    CALL SetTournamentWinner(v_tournament_name);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Picks`
--

DROP TABLE IF EXISTS `Picks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Picks` (
  `pick_id` int(11) NOT NULL AUTO_INCREMENT,
  `match_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `champion_id` int(11) NOT NULL,
  `position` enum("Mid","Top","Jungle","Bot","Support") NOT NULL,
  `level` int(11) NOT NULL,
  `statistics` varchar(20) NOT NULL,
  `dealt_damage` int(11) NOT NULL,
  `received_damage` int(11) NOT NULL,
  `earned_gold` int(11) NOT NULL,
  `item1_id` int(11) DEFAULT NULL,
  `item2_id` int(11) DEFAULT NULL,
  `item3_id` int(11) DEFAULT NULL,
  `item4_id` int(11) DEFAULT NULL,
  `item5_id` int(11) DEFAULT NULL,
  `item6_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`pick_id`),
  KEY `match_id` (`match_id`),
  KEY `player_id` (`player_id`),
  KEY `champion_id` (`champion_id`),
  KEY `item1_id` (`item1_id`),
  KEY `item2_id` (`item2_id`),
  KEY `item3_id` (`item3_id`),
  KEY `item4_id` (`item4_id`),
  KEY `item5_id` (`item5_id`),
  KEY `item6_id` (`item6_id`),
  CONSTRAINT `Picks_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `Matches` (`match_id`),
  CONSTRAINT `Picks_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `Players` (`player_id`),
  CONSTRAINT `Picks_ibfk_3` FOREIGN KEY (`champion_id`) REFERENCES `Champions` (`champion_id`),
  CONSTRAINT `Picks_ibfk_4` FOREIGN KEY (`item1_id`) REFERENCES `Items` (`item_id`),
  CONSTRAINT `Picks_ibfk_5` FOREIGN KEY (`item2_id`) REFERENCES `Items` (`item_id`),
  CONSTRAINT `Picks_ibfk_6` FOREIGN KEY (`item3_id`) REFERENCES `Items` (`item_id`),
  CONSTRAINT `Picks_ibfk_7` FOREIGN KEY (`item4_id`) REFERENCES `Items` (`item_id`),
  CONSTRAINT `Picks_ibfk_8` FOREIGN KEY (`item5_id`) REFERENCES `Items` (`item_id`),
  CONSTRAINT `Picks_ibfk_9` FOREIGN KEY (`item6_id`) REFERENCES `Items` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Picks`
--

LOCK TABLES `Picks` WRITE;
/*!40000 ALTER TABLE `Picks` DISABLE KEYS */;
INSERT INTO `Picks` VALUES
(1,1,1,1,"Mid",12,"6/2/4",18500,12500,15000,1,2,3,4,5,6),
(2,1,2,7,"Top",13,"5/4/7",17500,13000,14800,7,8,9,10,11,12),
(3,1,3,10,"Jungle",11,"3/5/12",16000,14000,13500,13,14,15,16,17,18),
(4,1,4,15,"Bot",11,"7/3/9",19000,12700,15500,19,20,21,22,13,14),
(5,1,5,21,"Support",10,"1/4/15",13000,13500,12500,15,22,13,14,19,3),
(6,2,6,2,"Mid",14,"8/2/3",20000,12000,16000,2,4,6,8,10,12),
(7,2,7,8,"Top",15,"4/4/6",19500,12800,15700,14,16,18,20,22,14),
(8,2,8,13,"Jungle",12,"3/6/10",16800,14300,14500,22,18,13,2,4,6),
(9,2,9,20,"Bot",13,"6/2/8",18400,12600,15400,8,10,12,14,16,18),
(10,2,10,18,"Support",11,"2/5/14",13500,13900,12600,1,3,5,7,9,11),
(11,5,1,1,"Mid",12,"6/2/4",18500,12500,15000,6,6,6,6,6,6),
(12,5,2,7,"Top",13,"5/4/7",17500,13000,14800,12,12,12,12,12,12),
(13,5,3,10,"Jungle",11,"3/5/12",16000,14000,13500,18,18,18,18,18,18),
(14,5,4,15,"Bot",11,"7/3/9",19000,12700,15500,14,14,14,14,14,14),
(15,5,5,21,"Support",10,"1/4/15",13000,13500,12500,3,3,3,3,3,3),
(16,5,6,2,"Mid",14,"8/2/3",20000,12000,16000,12,12,12,12,12,12),
(17,5,7,8,"Top",15,"4/4/6",19500,12800,15700,14,14,14,14,14,14),
(18,5,8,13,"Jungle",12,"3/6/10",16800,14300,14500,6,6,6,6,6,6),
(19,5,10,18,"Support",11,"2/5/14",13500,13900,12600,11,11,11,11,11,11),
(20,5,9,20,"Bot",13,"6/2/8",18400,12600,15400,18,18,18,18,18,18),
(21,6,1,1,"Mid",12,"6/2/4",18500,12500,15000,6,6,6,6,6,6),
(22,6,2,7,"Top",13,"5/4/7",17500,13000,14800,12,12,12,12,12,12),
(23,6,3,10,"Jungle",11,"3/5/12",16000,14000,13500,18,18,18,18,18,18),
(24,6,4,15,"Bot",11,"7/3/9",19000,12700,15500,14,14,14,14,14,14),
(25,6,5,21,"Support",10,"1/4/15",13000,13500,12500,3,3,3,3,3,3),
(26,6,6,2,"Mid",14,"8/2/3",20000,12000,16000,12,12,12,12,12,12),
(27,6,7,8,"Top",15,"4/4/6",19500,12800,15700,14,14,14,14,14,14),
(28,6,8,13,"Jungle",12,"3/6/10",16800,14300,14500,6,6,6,6,6,6),
(29,6,10,18,"Support",11,"2/5/14",13500,13900,12600,11,11,11,11,11,11),
(30,6,9,20,"Bot",13,"6/2/8",18400,12600,15400,18,18,18,18,18,18),
(31,7,1,1,"Mid",12,"6/2/4",18500,12500,15000,6,6,6,6,6,6),
(32,7,2,7,"Top",13,"5/4/7",17500,13000,14800,12,12,12,12,12,12),
(33,7,3,10,"Jungle",11,"3/5/12",16000,14000,13500,18,18,18,18,18,18),
(34,7,4,15,"Bot",11,"7/3/9",19000,12700,15500,14,14,14,14,14,14),
(35,7,5,21,"Support",10,"1/4/15",13000,13500,12500,3,3,3,3,3,3),
(36,7,6,2,"Mid",14,"8/2/3",20000,12000,16000,12,12,12,12,12,12),
(37,7,7,8,"Top",15,"4/4/6",19500,12800,15700,14,14,14,14,14,14),
(38,7,8,13,"Jungle",12,"3/6/10",16800,14300,14500,6,6,6,6,6,6),
(39,7,10,18,"Support",11,"2/5/14",13500,13900,12600,11,11,11,11,11,11),
(40,7,9,20,"Bot",13,"6/2/8",18400,12600,15400,18,18,18,18,18,18);
/*!40000 ALTER TABLE `Picks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `PlayerView`
--

DROP TABLE IF EXISTS `PlayerView`;
/*!50001 DROP VIEW IF EXISTS `PlayerView`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `PlayerView` AS SELECT
 1 AS `player_id`,
  1 AS `nickname`,
  1 AS `team_id`,
  1 AS `handedness`,
  1 AS `nationality`,
  1 AS `date_joined`,
  1 AS `date_left` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Players`
--

DROP TABLE IF EXISTS `Players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Players` (
  `player_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(1019) NOT NULL,
  `last_name` varchar(666) NOT NULL,
  `height` decimal(5,2) DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `nickname` varchar(32) NOT NULL,
  `team_id` int(11) NOT NULL,
  `handedness` enum("Right","Left","Ambidextrous") DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `nationality` varchar(60) DEFAULT NULL,
  `date_joined` date NOT NULL,
  `date_left` date DEFAULT NULL,
  PRIMARY KEY (`player_id`),
  KEY `idx_team_membership` (`team_id`,`date_joined`,`date_left`),
  CONSTRAINT `Players_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `Teams` (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Players`
--

LOCK TABLES `Players` WRITE;
/*!40000 ALTER TABLE `Players` DISABLE KEYS */;
INSERT INTO `Players` VALUES
(1,"John","Doe",185.50,80.30,"Blastmaster",1,"Right","1998-05-15","American","2022-01-15",NULL),
(2,"Mike","Johnson",190.20,95.10,"SteelJuggernaut",1,"Right","1993-12-10","British","2021-12-05",NULL),
(3,"Olivia","Nguyen",170.90,64.30,"StormPhoenix",1,"Right","1998-12-20","Vietnamese","2022-03-05","2023-05-18"),
(4,"Alice","Wang",162.50,54.00,"RapidFire",1,"Left","1999-10-30","Chinese","2022-01-20",NULL),
(5,"Ethan","Taylor",178.40,73.60,"Thunderstrike",1,"Right","1997-06-11","Australian","2022-02-11",NULL),
(6,"Jane","Smith",175.80,68.70,"ShadowStriker",2,"Left","2000-07-22","Canadian","2022-03-10","2023-04-20"),
(7,"Daniel","Lee",175.00,70.20,"PhantomBlade",2,"Left","1999-03-14","South Korean","2022-01-05",NULL),
(8,"Ava","Patel",169.20,62.40,"InfernoWielder",2,"Right","1997-04-11","Indian","2022-01-02",NULL),
(9,"Hannah","Zimmerman",167.60,60.30,"FrostArrow",2,"Right","1996-08-19","German","2022-04-12",NULL),
(10,"Lucas","Gonzalez",180.30,76.80,"WarriorHeart",2,"Left","1998-11-05","Spanish","2022-05-09",NULL),
(11,"Emily","Brown",165.30,55.50,"SwiftSerpent",3,"Right","1997-09-28","Australian","2022-02-20",NULL),
(12,"William","Martinez",187.50,82.60,"IronKnight",3,"Left","1995-08-17","Spanish","2022-04-10",NULL),
(13,"Emma","Jones",160.00,50.00,"IceShard",3,"Right","2001-01-15","American","2022-03-22",NULL),
(14,"Mason","Rodriguez",182.90,79.40,"BlazeRunner",3,"Right","1994-07-03","Mexican","2022-06-18",NULL),
(15,"Isabella","Martini",173.20,65.30,"NightHawk",3,"Left","1999-12-12","Italian","2022-07-25",NULL),
(16,"Sophia","Garcia",182.10,78.80,"ViperQueen",4,"Right","1996-11-03","Mexican","2022-01-30",NULL),
(17,"Liam","Kim",178.70,75.00,"ShadowSword",4,"Right","2001-02-08","South Korean","2022-02-15",NULL),
(18,"Jacob","Muller",183.50,84.20,"StormBrewer",4,"Left","1993-03-25","German","2022-08-19",NULL),
(19,"Mia","Thompson",168.40,57.10,"StarGazer",4,"Right","1998-04-10","British","2022-09-30",NULL),
(20,"Noah","Davis",175.90,72.60,"EagleEye",4,"Left","2000-05-21","American","2022-11-11",NULL);
/*!40000 ALTER TABLE `Players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `TeamStatistics`
--

DROP TABLE IF EXISTS `TeamStatistics`;
/*!50001 DROP VIEW IF EXISTS `TeamStatistics`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `TeamStatistics` AS SELECT
 1 AS `team_id`,
  1 AS `team_name`,
  1 AS `total_matches`,
  1 AS `total_wins`,
  1 AS `total_losses`,
  1 AS `avg_match_duration` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Teams`
--

DROP TABLE IF EXISTS `Teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Teams` (
  `team_id` int(11) NOT NULL AUTO_INCREMENT,
  `team_name` varchar(30) NOT NULL,
  `sponsors` text DEFAULT NULL,
  PRIMARY KEY (`team_id`),
  UNIQUE KEY `team_name` (`team_name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Teams`
--

LOCK TABLES `Teams` WRITE;
/*!40000 ALTER TABLE `Teams` DISABLE KEYS */;
INSERT INTO `Teams` VALUES
(1,"DWG KIA",NULL),
(2,"Team Liquid",NULL),
(3,"T1",NULL),
(4,"G2",NULL);
/*!40000 ALTER TABLE `Teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tournaments`
--

DROP TABLE IF EXISTS `Tournaments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tournaments` (
  `tournament_id` int(11) NOT NULL AUTO_INCREMENT,
  `tournament_name` varchar(40) NOT NULL,
  `winner_id` int(11) DEFAULT NULL,
  `prize_pool` int(11) DEFAULT NULL,
  PRIMARY KEY (`tournament_id`),
  UNIQUE KEY `tournament_name` (`tournament_name`),
  KEY `winner_id` (`winner_id`),
  CONSTRAINT `Tournaments_ibfk_1` FOREIGN KEY (`winner_id`) REFERENCES `Teams` (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tournaments`
--

LOCK TABLES `Tournaments` WRITE;
/*!40000 ALTER TABLE `Tournaments` DISABLE KEYS */;
INSERT INTO `Tournaments` VALUES
(1,"Worlds 2022",1,2000000),
(2,"MSI 2022",1,400000),
(3,"LCS Summer Split 2022",2,50000),
(4,"LCK Spring Split 2022",3,100000),
(5,"Summer Cup 2023",2,NULL);
/*!40000 ALTER TABLE `Tournaments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database "league"
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = "STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" */ ;
/*!50003 DROP FUNCTION IF EXISTS `CalculateTeamWinRate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateTeamWinRate`(p_team_name VARCHAR(30)) RETURNS decimal(5,2)
BEGIN
    DECLARE total_matches INT;
    DECLARE total_wins INT;
    DECLARE v_team_id INT;
    DECLARE win_rate DECIMAL(5,2);
    
    SELECT team_id into v_team_id FROM Teams WHERE team_name = p_team_name;
    

    SELECT COUNT(*) INTO total_matches 
    FROM Matches
    WHERE team1_id = v_team_id OR team2_id = v_team_id;

    SELECT COUNT(*) INTO total_wins 
    FROM Matches
    WHERE winner_id = v_team_id;

    IF total_matches > 0 THEN
        SET win_rate = (total_wins / total_matches) * 100;
    ELSE
        SET win_rate = 0;
    END IF;

    RETURN win_rate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = "STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddMatchToTournament` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMatchToTournament`(
    IN p_tournament_name VARCHAR(40),
    IN p_date_played DATE,
    IN p_winner_team_name VARCHAR(30),
    IN p_team1_name VARCHAR(30),
    IN p_team2_name VARCHAR(30),
    IN p_duration_minutes TIME,
    IN p_player_data TEXT 
)
BEGIN

    DECLARE v_tournament_id INT;
    DECLARE v_winner_team_id INT;
    DECLARE v_team1_id INT;
    DECLARE v_team2_id INT;
    DECLARE v_match_id INT;
    DECLARE v_player_id INT;
    DECLARE v_champion_id INT;
    DECLARE v_position ENUM("Mid", "Top", "Jungle", "Bot", "Support");
    DECLARE v_level INT;
    DECLARE v_statistics VARCHAR(20);
    DECLARE v_dealt_damage INT;
    DECLARE v_received_damage INT;
    DECLARE v_earned_gold INT;
    DECLARE v_item_ids TEXT;
    DECLARE v_index INT DEFAULT 1;
    DECLARE v_player_data_entry VARCHAR(255);
    DECLARE v_end_index INT;
    DECLARE v_item_id1 INT;
    DECLARE v_item_id2 INT;
    DECLARE v_item_id3 INT;
    DECLARE v_item_id4 INT;
    DECLARE v_item_id5 INT;
    DECLARE v_item_id6 INT;
    DECLARE v_player_team_id INT;
    DECLARE v_champions_team1 TEXT DEFAULT "";
    DECLARE v_champions_team2 TEXT DEFAULT "";
    DECLARE v_team1_player_count INT DEFAULT 0;
    DECLARE v_team2_player_count INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        
        ROLLBACK;
        RESIGNAL;
    END;

    
    START TRANSACTION;

    
    INSERT INTO Tournaments (tournament_name) VALUES (p_tournament_name)
    ON DUPLICATE KEY UPDATE tournament_id = LAST_INSERT_ID(tournament_id);
    SET v_tournament_id = LAST_INSERT_ID();

    
    INSERT INTO Teams (team_name) VALUES (p_team1_name)
    ON DUPLICATE KEY UPDATE team_id = LAST_INSERT_ID(team_id);
    SET v_team1_id = LAST_INSERT_ID();

    
    INSERT INTO Teams (team_name) VALUES (p_team2_name)
    ON DUPLICATE KEY UPDATE team_id = LAST_INSERT_ID(team_id);
    SET v_team2_id = LAST_INSERT_ID();

    
    INSERT INTO Teams (team_name) VALUES (p_winner_team_name)
    ON DUPLICATE KEY UPDATE team_id = LAST_INSERT_ID(team_id);
    SET v_winner_team_id = LAST_INSERT_ID();

    
    IF v_winner_team_id NOT IN (v_team1_id, v_team2_id) THEN
        SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Winner team is not a playing team";
    END IF;

    
    INSERT INTO Matches (date_played, winner_id, duration_minutes, tournament_id, team1_id, team2_id)
    VALUES (p_date_played, v_winner_team_id, p_duration_minutes, v_tournament_id, v_team1_id, v_team2_id);
    SET v_match_id = LAST_INSERT_ID();

    
    SET v_end_index = (CHAR_LENGTH(p_player_data) - CHAR_LENGTH(REPLACE(p_player_data, ",", ""))) / CHAR_LENGTH(",");

    
    WHILE v_index <= v_end_index + 1 DO
        SET v_player_data_entry = SUBSTRING_INDEX(SUBSTRING_INDEX(p_player_data, ",", v_index), ",", -1);

        
        SET v_player_id = CONVERT(SUBSTRING_INDEX(v_player_data_entry, ":", 1), UNSIGNED INTEGER);
        SET v_champion_id = CONVERT(SUBSTRING_INDEX(SUBSTRING_INDEX(v_player_data_entry, ":", 2), ":", -1), UNSIGNED INTEGER);
        SET v_position = SUBSTRING_INDEX(SUBSTRING_INDEX(v_player_data_entry, ":", 3), ":", -1);
        SET v_level = CONVERT(SUBSTRING_INDEX(SUBSTRING_INDEX(v_player_data_entry, ":", 4), ":", -1), UNSIGNED INTEGER);
        SET v_statistics = SUBSTRING_INDEX(SUBSTRING_INDEX(v_player_data_entry, ":", 5), ":", -1);
        SET v_dealt_damage = CONVERT(SUBSTRING_INDEX(SUBSTRING_INDEX(v_player_data_entry, ":", 6), ":", -1), UNSIGNED INTEGER);
        SET v_received_damage = CONVERT(SUBSTRING_INDEX(SUBSTRING_INDEX(v_player_data_entry, ":", 7), ":", -1), UNSIGNED INTEGER);
        SET v_earned_gold = CONVERT(SUBSTRING_INDEX(SUBSTRING_INDEX(v_player_data_entry, ":", 8), ":", -1), UNSIGNED INTEGER);
        SET v_item_ids = SUBSTRING_INDEX(v_player_data_entry, ":", -1);

        
        SELECT team_id INTO v_player_team_id FROM Players WHERE player_id = v_player_id;
        IF v_player_team_id NOT IN (v_team1_id, v_team2_id) THEN
            SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Player is not part of the playing teams";
        END IF;

        
        IF v_player_team_id = v_team1_id THEN
            SET v_team1_player_count = v_team1_player_count + 1;
            IF v_team1_player_count > 5 THEN
                SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "More than 5 players in Team 1";
            END IF;
            
            IF FIND_IN_SET(v_champion_id, v_champions_team1) THEN
                SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Duplicate champion in Team 1";
            ELSE
                SET v_champions_team1 = CONCAT_WS(",", v_champions_team1, v_champion_id);
            END IF;
        ELSEIF v_player_team_id = v_team2_id THEN
            SET v_team2_player_count = v_team2_player_count + 1;
            IF v_team2_player_count > 5 THEN
                SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "More than 5 players in Team 2";
            END IF;
            
            IF FIND_IN_SET(v_champion_id, v_champions_team2) THEN
                SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Duplicate champion in Team 2";
            ELSE
                SET v_champions_team2 = CONCAT_WS(",", v_champions_team2, v_champion_id);
            END IF;
        END IF;

        
        SET v_item_id1 = CONVERT(SUBSTRING_INDEX(v_item_ids, ",", 1), UNSIGNED INTEGER);
        SET v_item_id2 = CONVERT(SUBSTRING_INDEX(SUBSTRING_INDEX(v_item_ids, ",", 2), ",", -1), UNSIGNED INTEGER);
        SET v_item_id3 = CONVERT(SUBSTRING_INDEX(SUBSTRING_INDEX(v_item_ids, ",", 3), ",", -1), UNSIGNED INTEGER);
        SET v_item_id4 = CONVERT(SUBSTRING_INDEX(SUBSTRING_INDEX(v_item_ids, ",", 4), ",", -1), UNSIGNED INTEGER);
        SET v_item_id5 = CONVERT(SUBSTRING_INDEX(SUBSTRING_INDEX(v_item_ids, ",", 5), ",", -1), UNSIGNED INTEGER);
        SET v_item_id6 = CONVERT(SUBSTRING_INDEX(v_item_ids, ",", -1), UNSIGNED INTEGER);

        
        INSERT INTO Picks (match_id, player_id, champion_id, position, level, statistics, dealt_damage, received_damage, earned_gold, item1_id, item2_id, item3_id, item4_id, item5_id, item6_id)
        VALUES (v_match_id, v_player_id, v_champion_id, v_position, v_level, v_statistics, v_dealt_damage, v_received_damage, v_earned_gold, v_item_id1, v_item_id2, v_item_id3, v_item_id4, v_item_id5, v_item_id6);

        SET v_index = v_index + 1;
    END WHILE;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = "STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetTournamentWinner` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetTournamentWinner`(IN p_tournament_name VARCHAR(40))
BEGIN
    DECLARE v_tournament_id INT;
    DECLARE v_winner_team_id INT;

    
    SELECT tournament_id INTO v_tournament_id FROM Tournaments WHERE tournament_name = p_tournament_name;
    IF v_tournament_id IS NULL THEN
        SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Tournament not found";
    END IF;

    
    SELECT winner_id INTO v_winner_team_id
    FROM Matches
    WHERE tournament_id = v_tournament_id
    GROUP BY winner_id
    ORDER BY COUNT(*) DESC
    LIMIT 1;

    
    UPDATE Tournaments
    SET winner_id = v_winner_team_id
    WHERE tournament_id = v_tournament_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `ChampionStatistics`
--

/*!50001 DROP VIEW IF EXISTS `ChampionStatistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ChampionStatistics` AS select `C`.`champion_id` AS `champion_id`,`C`.`name` AS `champion_name`,`C`.`difficulty` AS `champion_difficulty`,count(`P`.`champion_id`) AS `total_picks`,sum(`P`.`dealt_damage`) AS `total_dealt_damage`,avg(`P`.`dealt_damage`) AS `average_dealt_damage`,sum(`P`.`received_damage`) AS `total_received_damage`,avg(`P`.`received_damage`) AS `average_received_damage`,sum(`P`.`earned_gold`) AS `total_earned_gold`,avg(`P`.`earned_gold`) AS `average_earned_gold` from (`Champions` `C` left join `Picks` `P` on(`C`.`champion_id` = `P`.`champion_id`)) group by `C`.`champion_id`,`C`.`name`,`C`.`difficulty` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PlayerView`
--

/*!50001 DROP VIEW IF EXISTS `PlayerView`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `PlayerView` AS select `Players`.`player_id` AS `player_id`,`Players`.`nickname` AS `nickname`,`Players`.`team_id` AS `team_id`,`Players`.`handedness` AS `handedness`,`Players`.`nationality` AS `nationality`,`Players`.`date_joined` AS `date_joined`,`Players`.`date_left` AS `date_left` from `Players` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `TeamStatistics`
--

/*!50001 DROP VIEW IF EXISTS `TeamStatistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `TeamStatistics` AS select `T`.`team_id` AS `team_id`,`T`.`team_name` AS `team_name`,count(`M`.`match_id`) AS `total_matches`,sum(case when `T`.`team_id` = `M`.`winner_id` then 1 else 0 end) AS `total_wins`,count(`M`.`match_id`) - sum(case when `T`.`team_id` = `M`.`winner_id` then 1 else 0 end) AS `total_losses`,sec_to_time(avg(time_to_sec(`M`.`duration_minutes`))) AS `avg_match_duration` from (`Teams` `T` left join `Matches` `M` on(`T`.`team_id` = `M`.`team1_id` or `T`.`team_id` = `M`.`team2_id`)) group by `T`.`team_id`,`T`.`team_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-19 15:46:39
