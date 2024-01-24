SET FOREIGN_KEY_CHECKS=0;
create database musicplaylist;
use musicplaylist;

CREATE TABLE artist(
    id INT PRIMARY KEY,
    art_name VARCHAR(30),
    art_country VARCHAR(15),
    label VARCHAR(50)
);

CREATE TABLE album(
    a_id INT PRIMARY KEY,
    id INT,
    alb_title VARCHAR(50),
    year INT,
    FOREIGN KEY(id) REFERENCES artist(id)
);

CREATE TABLE  song(
    s_id INT PRIMARY KEY,
    a_id INT,
    id INT,
    duration FLOAT,
    s_title VARCHAR(50),
    genre VARCHAR(10),
    FOREIGN KEY(a_id) REFERENCES album(a_id),
    FOREIGN KEY(id) REFERENCES artist(id)
);

CREATE TABLE user(
    username VARCHAR(30) PRIMARY KEY,
    age INT,
    permission VARCHAR(15),
    password VARCHAR(15),
    country VARCHAR(15)
);

CREATE TABLE playlist(
    p_name VARCHAR(20) PRIMARY KEY,
    username VARCHAR(30),
    FOREIGN KEY(username) REFERENCES user(username)
);

CREATE TABLE created_play(
    p_name VARCHAR(20),
    s_id INT,
    PRIMARY KEY(p_name, s_id),
    FOREIGN KEY(p_name) REFERENCES playlist(p_name),
    FOREIGN KEY(s_id) REFERENCES song(s_id)
);

INSERT INTO created_play
VALUES
("OG Raps", 5),
("OG Raps", 8),
("Pop Classics", 4)
;

INSERT INTO playlist
VALUES
("OG Raps", "tony363"),
("Pop Classics", "cute.as.ducks")
;

INSERT INTO user
VALUES
("admin", 34, "admin", "password", "Turkey"),
("tony363", 19, "user", "123tony456", "USA"),
("average_student_xd", 18, "user", "420_xdxcxf", "United Kingdom"),
("cute.as.ducks", 22,"user", "12128989lol", "Italy")
;

INSERT INTO artist 
VALUES
(1,	"The Weeknd", "Canada", "XO"),
(2,	"The Neighbourhood", "US", "Columbia Records"),
(3,	"Lana Del Rey",	"US",	"Interscope Records"),
(4,	"Joji", "US", "88 Rising"),
(5,	"JID", "US", "Dreamville Records"),
(6,	"J.cole", "US",	"Dreamville Records"),
(7,	"2Pac", "US", "Death Row Records"),
(8,	"Kendrick Lamar", "US",	"pgLang"),
(9,	"Eminem", "US", "Shady Records"),
(10, "JAY-Z", "US", "Roc Nation"),
(11, "Wu-Tang Clan", "US", "Loud Records"),
(12, "The Notorious B.I.G.", "US", "Bad Boy Records"),
(13, "Mobb Deep", "US", "Loud Records"),
(14, "Ceza", "Turkey", "Esen Müzik"),
(15, "Hidra", "Turkey",	"Dokuz Sekiz Müzik"),
(16, "Jay Park", "Korea", "AOMG"),
(17, "Nafla", "Korea", "GROOVL1N"),
(18, "aespa", "Korea", "SM Entertainment"),
(19, "BIBI", "Korea", "88 Rising"),
(20, "Dreamcatcher", "Korea", "Dreamcatcher Company"),
(21, "LE SSERAFIM",	"Korea", "HYBE Entertarinment"),
(22, "New Jeans", "Korea", "HYBE Entertarinment"),
(23, "BLACKPINK", "Korea" ,	"YG Entertainment"),
(24, "Metallica", "US", "Elektra Records"),
(25, "Gojira", "French", "Roadrunner Records"),
(26, "Haggard",	"Germany", "Drakkar Entertainment"),
(27, "Slipknot", "US", "Roadrunner Records"),
(28, "Megadeth", "US", "Capitol Records"),
(29, "Rammstein", "Germany", "Universal Music"),
(30, "Iron Maiden",	"UK", "EMI"),
(31, "Led Zeppelin", "UK", "Atlantic Records"),
(32, "Queen", "UK", "EMI"),
(33, "Arctic Monkeys", "UK","Domino Recording Company")
;

INSERT INTO album 
VALUES 
(1,	    1,  "After Hours",	2020),
(2,	    1,  "Beaut Behind The Madness",	2015),
(3,	    1,  "Dawn FM",	2022),
(4,	    1,	"Trilogy",	2012),
(5,	    2,	"I Love You",	2013),
(6,	    2,	"Wiped Out!",	2015),
(7,	    3,	"Ultraviolence",	2014),
(8,	    4,	"BALLADS1",	2018),
(9,	    4,	"Run",	2020),
(10,	5,	"DiCaprio 2",	2018),
(11,	5,	"The Forever Story",	2022),
(12,	6,	"2014 Forest Hill Drive",	2014),
(13,	6,	"Off-Season",	2021),
(14,	7,	"All Eyez On Me",	1996),
(15,	8,	"Damn",	2017),
(16,	8,	"To Pimp A Butterfly",	2015),
(17,	9,	"Encore",	2004),
(18,	9,	"The Marshall Mathers LP",	2001),
(19,	10,	"4:44",	2017),
(20,	10,	"Reasonable Doubt",	1996),
(21,	11,	"Enter The Wu-Tang(36 Chambers)",	1993),
(22,	12,	"Life After Death",	1997),
(23,	13,	"The Infamous",	1995),
(24,	14,	"Rapstar",	2004),
(25,	15,	"Hedefte",	2013),
(26,	16,	"Worldwide",	2015),
(27,	17,	"Natural High",	2021),
(28,	18,	"Girls",	2022),
(29,	19,	"Lowlife Princess:Noir",	2022),
(30,	20,	"Dystopia:The Tree of Language",	2020),
(31,	21,	"ANTIFRAGILE",	2022),
(32,	22,	"New Jeans 1st EP 'New Jeans'",	2022),
(33,	23,	"THE ALBUM",	2020),
(34,	23,	"BORN PINK",	2022),
(35,	24,	"Ride The Lightning",	1984),
(36,	24,	"Master of Puppets",	1986),
(37,	24,	"…And Justice For All",	1988),
(38,	25,	"Magma",	2016),
(39,	26,	"Eppur si muove",	2004),
(40,	27,	"All Hope Is Gone",	2008),
(41,	27,	".5: The Gray Chapter",	2014),
(42,	28,	"Rust In Peace",	1990),
(43,	29,	"Mutter",	2001),
(44,	29,	"Rosenrot",	2005),
(45,	30,	"The Number Of The Beast",	1982),
(46,	31,	"Led Zeppelin IV",	1971),
(47,	32,	"A Night At The Opera",	1975),
(48,	33,	"AM",	2013),
(49,	33,	"Favourite Worst Nightmare",	2007)
;

INSERT INTO song 
VALUES
(1,	    1,	1,	4.07,	"Snowchild",	"R&B"),
(2,	    7,	3,	4.17,	"West Coast",	"Pop"),
(3,	    10,	5,	2.36,	"151 Rum",	"Hip-Hop"),
(4,	    5,	2,	4.00,	"Sweater Weather",	"Pop"),
(5,	    14,	7,	4.38,	"Ambition Az A Ridah",	"Hip-Hop"),
(6,	    19,	10,	3.51,	"The Story of O.J.",	"Hip-Hop"),
(7,	    1,	1,	3.18,	"Heartless",	"R&B"),
(8,	    22,	12,	3.50,	"Hypnotize",	"Hip-Hop"),
(9,	    8,	4,	3.29,	"Slow Dancing In The   Dark",	"R&B"),
(10,	24,	14,	4.02,	"Ben Aglamazken",	"Hip-Hop"),
(11,	26,	16,	3.24,	"MOMMAE",	"Hip-Hop"),
(12,	6,	2,	3.55,	"Cry Baby",	"Pop"),
(13,	21,	11,	4.12,	"C.R.E.A.M",	"Hip-Hop"),
(14,	28,	18,	4.00,	"Girls",	"Pop"),
(15,	11,	5,	3.49,	"Surround Sound",	"Hip-Hop"),
(16,	31,	21,	3.04,	"ANTIFRAGILE",	"Pop"),
(17,	15,	8,	3.05,	"DNA",	"Hip-Hop"),
(18,	1,	1,	3.20,	"Blinding Lights",	"R&B"),
(19,	33,	23,	3.19,	"Pretty Savage",	"Pop"),
(20,	19,	10,	4.44,	"4:44",	"Hip-Hop"),
(21,	14,	7,	5.08,	"All Eyez On Me",	"Hip-Hop"),
(22,	9,	4,	3.15,	"Run",	"R&B"),
(23,	27,	17,	3.05,	"mobb tang",	"Hip-Hop"),
(24,	12,	6,	3.59,	"Wet Dreamz",	"Hip-Hop"),
(25,	25,	15,	3.17,	"Olume Inat",	"Hip-Hop"),
(26,	35,	24,	5.09,	"For Whom The Bell Tolls",	"Metal"),
(27,	1,	1,	6.01,	"After Hours",	"R&B"),
(28,	23,	13,	5.26,	"Shock Ones, Pt.II",	"Hip-Hop"),
(29,	29,	19,	2.45,	"BIBI Vengeance",	"Pop"),
(30,	15,	8,	3.47,	"Loyalty",	"Hip-Hop"),
(31,	5,	2,	4.11,	"Afraid",	"Pop"),
(32,    26,	16,	4.04,	"YOU KNOW",	"Hip-Hop"),
(33,	35,	24,	6.57,	"Fade To Black",	"Metal"),
(34,	16,	8,	3.39,	"Alright",	"Hip-Hop"),
(35,	12,	6,	4.29,	"A Tale Of 2 Citiez",	"Hip-Hop"),
(36,	26,	16,	3.44,	"ON IT",	"Hip-Hop"),
(37,	20,	10,	3.41,	"Politics As Usual",	"Hip-Hop"),
(38,	2,	1,	6.17,	"Angel",	"R&B"),
(39,	27,	17,	3.47,	"run!",	"Hip-Hop"),
(40,	28,	18,	3.15,	"Illusion",	"Pop"),
(41,	17,	9,	4.10,	"Mockingbird",	"Hip-Hop"),
(42,	39,	26,	6.40,	"Per Aspera Ad Astra",	"Metal"),
(43,	36,	24,	8.35,	"Master Of Puppets",	"Metal"),
(44,	22,	12,	6.07,	"Notorious Thugs",	"Hip-Hop"),
(45,	7,	3,	5.52,	"Brooklyn Baby",	"Pop"),
(46,	24,	14,	3.27,	"Holocaust",	"Hip-Hop"),
(47,	40,	27,	4.44,	"Psychosocial",	"Metal"),
(48,	12,	6,	4.52,	"No Role Modelz",	"Hip-Hop"),
(49,	38,	25,	3.32,	"Silvera",  "Metal"),
(50,	42,	28,	6.32,	"Holy Wars…The Punishment Due -…",	"Metal"),
(51,	2,	1,	4.38,	"Earned It",	"R&B"),
(52,	37,	25,	7.26,	"One",	"Metal"),
(53,	43,	29,	4.39,	"Mein herz brennt",	"Metal"),
(54,	45,	30,	4.50,	"The Number Of The Beast",	"Metal"),
(55,	13,	6,	2.28,	"Amari",	"Hip-Hop"),
(56,	41,	28,	5.42,	"The Devil in I",	"Metal"),
(57,	46,	31,	4.55,	"Black Dog",	"Rock"),
(58,	17,	9,	4.57,	"Like Toy Soldiers",	"Hip-Hop"),
(59,	28,	18,	2.54,	"Black Mamba",	"Pop"),
(60,	3,	1,	3.09,	"Sacrifice",	"R&B"),
(61,	44,	29,	3.54,	"Rosenrot",	"Metal"),
(62,	32,	22,	3.00,	"Attention",	"Pop"),
(63,	40,	27,	4.36,	"Snuff",	"Rock"),
(64,	42,	28,	5.19,	"Tornado Of Souls",	"Metal"),
(65,	18,	9,	6.44,	"Stan",	"Hip-Hop"),
(66,	6,	2,	4.20,	"Daddy Issues",	"Pop"),
(67,	33,	23,	3.00,	"How You Like That",	"Pop"),
(68,	41,	27,	3.45,	"Killpop",	"Metal"),
(69,	45,	30,	3.53,	"Run to the Hills",	"Rock"),
(70,	47,	32,	2.50,	"You're My Best Friend",	"Rock"),
(71,	29,	19,	3.23,	"Animal Farm",	"Pop"),
(72,	48,	33,	3.21,	"R U Mine?",	"Rock"),
(73,	49,	33,	3.03,	"Fluorescent Adolescent",	"Rock"),
(74,	30,	20,	3.05,	"Red Sun",	"Rock"),
(75,	43,	29,	4.32,	"Sonne",	"Metal"),
(76,	3,	1,	3.34,	"Out Of Time",	"R&B"),
(77,	18,	9,	4.44,	"The Real Slim Shady",	"Hip-Hop"),
(78,	34,	23,	3.06,	"Pink Venom",	"Pop"),
(79,	47,	32,	3.37,	"Love of My Life",	"Rock"),
(80,	46,	31,	8.02,	"Stairway to Heaven",	"Rock"),
(81,	47,	32,	5.54,	"Bohemian Rhapsody",	"Rock"),
(82,	23,	13,	3.45,	"Survival Of The Fittest",	"Hip-Hop"),
(83,	45,	30,	7.11,	"Hallowed Be Thy Name",	"Rock"),
(84,	31,	21,	3.16,	"Impurities",	"Pop"),
(85,	39,	26,	4.50,	"Herr Mannelig",	"Metal"),
(86,	44,	29,	3.46,	"Benzin",	"Metal"),
(87,	4,	1,	5.12,	"The Morning",	"R&B"),
(88,	49,	33,	4.13,	"505",	"Rock"),
(89,	48,	33,	3.27,	"Arabella",	"Rock"),
(90,	37,	24,	6.42,	"Blackened",	"Metal"),
(91,	20,	10,	4.26,	"Dead Presidents II",	"Hip-Hop"),
(92,	34,	23,	2.59,	"Typa Girl",	"Pop"),
(93,	43,	29,	4.28,	"Mutter",	"Metal"),
(94,	39,	26,	8.19,	"Eppur si muove",	"Metal"),
(95,	38,	25,	5.42,	"The Shooting Star",	"Metal"),
(96,	30,	20,	3.24,	"Scream",	"Rock"),
(97,	48,	33,	4.03,	"No.1 Party Anthem",	"Rock"),
(98,	32,	22,	2.59,	"Hype Boy",	"Pop"),
(99,	48,	33,	4.32,	"Do I Wanna Know?",	"Rock"),
(100,	21,	11,	5.51,	"Method Man",	"Hip-Hop")
;

/*Query to display all artists, albums, songs, and song duration ordered in ascending order by artist, album, and song*/
CREATE TABLE comp_table  SELECT a.art_name, al.alb_title, s.s_title, s.duration FROM artist a
JOIN album al ON a.id = al.id
JOIN song s ON al.a_id = s.a_id
ORDER BY a.art_name ASC, al.alb_title ASC, s.s_title ASC;

/*Query to list the total duration of songs in an album and order the album durations by descending order*/
CREATE TABLE dur_table SELECT al.alb_title, SUM(s.duration) AS total_duration FROM album al
JOIN song s ON al.a_id = s.a_id
GROUP BY al.a_id, al.alb_title
ORDER BY total_duration DESC;

/*Query to retrieve the number of songs each artist has and the artist who has the most songs in the database*/
CREATE TABLE count_table SELECT a.art_name, COUNT(s.s_id) AS song_count
FROM artist a
JOIN album al ON a.id = al.id
JOIN song s ON al.a_id = s.a_id
GROUP BY a.id, a.art_name
ORDER BY song_count DESC;

/*Query to list the artists by their most produced genre*/
CREATE TABLE genre_table SELECT DISTINCT A.art_name, S.genre
FROM artist A
JOIN album AL ON A.id = AL.id
JOIN song S ON AL.a_id = S.a_id
JOIN (
  SELECT id, genre, COUNT(*) AS genre_count
  FROM song
  GROUP BY id, genre
) AS SG ON A.id = SG.id AND S.genre = SG.genre
WHERE SG.genre_count = (
  SELECT MAX(genre_count)
  FROM (
    SELECT id, genre, COUNT(*) AS genre_count
    FROM song
    GROUP BY id, genre
  ) AS counts
  WHERE counts.id = A.id
)
ORDER BY A.art_name ASC;

/*Query to list the songs in a playlist and its information*/
CREATE TABLE p_data SELECT p.p_name AS Playlist_Name, u.username AS Creator, s.s_title AS Song_Title, s.duration AS Song_Duration
FROM playlist p
JOIN created_play cp ON p.p_name = cp.p_name
JOIN song s ON cp.s_id = s.s_id
JOIN user u ON p.username = u.username;

SHOW TABLES;
SELECT * FROM artist;
SELECT * FROM album;
SELECT * FROM song;
SELECT * FROM user;
SELECT * FROM playlist;
SELECT * FROM created_play;
SELECT * FROM comp_table;
SELECT * FROM dur_table;
SELECT * FROM count_table;
SELECT * FROM genre_table;
SELECT * FROM p_data;