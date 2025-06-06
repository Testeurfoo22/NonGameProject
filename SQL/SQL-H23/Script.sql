begin transaction; 

DROP TABLE if exists Apparition;
DROP TABLE if exists Carton;
DROP TABLE if exists But;
DROP TABLE if exists Match;
DROP TABLE if exists Arbitre;
DROP TABLE if exists Humain;
DROP TABLE if exists Equipe;

create table Equipe(
    NTEAM varchar(50) primary key not null,
	CODE text not null,
	NOMEQ text not null,
    GROUPE text not null
);

create table Humain(
    NPERS varchar(50) primary key not null,
    NOM text not null,
    PRENOM text not null,
	NUMO int,
    POSTE text not null check (POSTE IN ('GB', 'DEF', 'MIL', 'ATT', 'ENT', 'ARB')),
	NATIONALITE text not null,
    AGE int,
	NTEAM varchar(50) references Equipe(NTEAM)
);

create table Arbitre(
    NARBT varchar(50) primary key not null,  
    NPRIN varchar(50) references Humain(NPERS) not null, --where POSTE = 'ARB',
    NAST1 varchar(50) references Humain(NPERS) not null, --where POSTE = 'ARB',
    NAST2 varchar(50) references Humain(NPERS) not null, --where POSTE = 'ARB',
    NAST3 varchar(50) references Humain(NPERS) not null --where POSTE = 'ARB',
    --CONSTRAINT unique_arbitre_Humain UNIQUE (NPRIN, NAST1, NAST2, NAST3)
);

create table Match(
    NMATH varchar(50) primary key not null,
    GROUPE text,
    DATE timestamp default NOW() not null,
    NARBT varchar(50) references Arbitre(NARBT) not null,
    NDOMI varchar(50) references Equipe(NTEAM) not null,
    NEXTE varchar(50) references Equipe(NTEAM) not null,
    CONSTRAINT unique_Team UNIQUE (NDOMI, NEXTE),
    RANG text not null check (RANG IN ('Groupe', '8th', '4th', '2th', 'Petite Finale','Finale')),
    STADE text not null,
    RESULTAT text not null,
    TAB text,
    VAINQUEUR text not null check (VAINQUEUR IN ('Nul', 'Dom', 'Ext'))
);

create table But(
    NMATH varchar(50) references Match(NMATH) not null,
    NTEAM varchar(50) references Equipe(NTEAM) not null,
    BUTEUR varchar(50) references Humain(NPERS) not null,
    PASSEUR varchar(50) references Humain(NPERS),
    RANG text not null check (RANG IN ('BUT', 'PENO', 'CSC')),
    TIME INTEGER CHECK (TIME >= 0 AND TIME <= 200) not null
);

create table Carton(
    NMATH varchar(50) references Match(NMATH) not null,
    NTEAM varchar(50) references Equipe(NTEAM) not null,
    NPERS varchar(50) references Humain(NPERS) not null,
    TYPE text not null check (TYPE IN ('JAUNE', 'ROUGE')),
    TIME INTEGER CHECK (TIME >= 0 AND TIME <= 200) not null
);

create table Apparition(
	NPERS varchar(50) references Humain(NPERS) not null,
	NMATH varchar(50) references Match(NMATH) not null,
	ENTREE INTEGER CHECK (ENTREE >= 0 AND ENTREE <= 200) not null,
    SORTIE INTEGER CHECK (SORTIE >= 0 AND SORTIE <= 200)
);

INSERT INTO Equipe VALUES ('20220001', 'FRA','France','D');
INSERT INTO Equipe VALUES ('20220002', 'GER','Allemagne','E');
INSERT INTO Equipe VALUES ('20220003', 'ENG','Angleterre','B');
INSERT INTO Equipe VALUES ('20220004', 'ESP','Espagne','E');
INSERT INTO Equipe VALUES ('20220005', 'BRA','Bresil', 'G');
INSERT INTO Equipe VALUES ('20220006', 'CRO','Croatie','F');
INSERT INTO Equipe VALUES ('20220007', 'MEX','Mexique','C');
INSERT INTO Equipe VALUES ('20220008', 'CMR','Cameroun','G');
INSERT INTO Equipe VALUES ('20220009', 'NED','Pays-Bas','A');
INSERT INTO Equipe VALUES ('20220010', 'AUS','Australie','D');
INSERT INTO Equipe VALUES ('20220011', 'URU','Uruguay','H');
INSERT INTO Equipe VALUES ('20220012', 'CRC','Costa Rica','E');
INSERT INTO Equipe VALUES ('20220013', 'JAP','Japon','E');
INSERT INTO Equipe VALUES ('20220014', 'SUI','Suisse','G');
INSERT INTO Equipe VALUES ('20220015', 'ECU','Equateur','A');
INSERT INTO Equipe VALUES ('20220016', 'POR','Portugal','H');
INSERT INTO Equipe VALUES ('20220017', 'IRN','Iran','B');
INSERT INTO Equipe VALUES ('20220018', 'USA','Etats-Unis','B');
INSERT INTO Equipe VALUES ('20220019', 'GHA','Ghana','H');
INSERT INTO Equipe VALUES ('20220020', 'BEL','Belgique','F');
INSERT INTO Equipe VALUES ('20220021', 'KSA','Arabie Saoudite','C');
INSERT INTO Equipe VALUES ('20220022', 'WAL','Pays De Galles','B');
INSERT INTO Equipe VALUES ('20220023', 'SRB','Serbie','G');
INSERT INTO Equipe VALUES ('20220024', 'ARG','Argentine','C');
INSERT INTO Equipe VALUES ('20220025', 'CAN','Canada','F');
INSERT INTO Equipe VALUES ('20220026', 'KOR','Corée Du Sud','H');
INSERT INTO Equipe VALUES ('20220027', 'DEN','Danemark','D');
INSERT INTO Equipe VALUES ('20220028', 'MAR','Maroc','F');
INSERT INTO Equipe VALUES ('20220029', 'POL','Pologne','C');
INSERT INTO Equipe VALUES ('20220030', 'QAT','Qatar','A');
INSERT INTO Equipe VALUES ('20220031', 'SEN','Sénégal','A');
INSERT INTO Equipe VALUES ('20220032', 'TUN','Tunisie','D');

INSERT INTO Humain VALUES ('00001','Deschamps','Didier', null, 'ENT', 'FRA', 54, '20220001');
INSERT INTO Humain VALUES ('00002','Lloris','Hugo', 1, 'GB', 'FRA', 35, '20220001');
INSERT INTO Humain VALUES ('00003','Pavard','Benjamin', 2, 'DEF', 'FRA', 26, '20220001');
INSERT INTO Humain VALUES ('00004','Disasi','Axel', 3, 'DEF', 'FRA', 24, '20220001');
INSERT INTO Humain VALUES ('00005','Varane','Raphaël', 4, 'DEF', 'FRA', 29, '20220001');
INSERT INTO Humain VALUES ('00006','Koundé','Jules', 5, 'DEF', 'FRA', 24, '20220001');
INSERT INTO Humain VALUES ('00007','Guendouzi','Mattéo', 6, 'MIL', 'FRA', 23, '20220001');
INSERT INTO Humain VALUES ('00008','Griezmann','Antoine', 7, 'ATT', 'FRA', 31, '20220001');
INSERT INTO Humain VALUES ('00009','Tchouaméni','Aurélien', 8, 'MIL', 'FRA', 22, '20220001');
INSERT INTO Humain VALUES ('00010','Giroud','Olivier', 9, 'ATT', 'FRA', 36, '20220001');
INSERT INTO Humain VALUES ('00011','Mbappé','Kylian', 10, 'ATT', 'FRA', 23, '20220001');
INSERT INTO Humain VALUES ('00012','Dembélé','Ousmane', 11, 'ATT', 'FRA', 25, '20220001');
INSERT INTO Humain VALUES ('00013','Kolo Muani','Randal', 12, 'ATT', 'FRA', 23, '20220001');
INSERT INTO Humain VALUES ('00014','Fofana','Youssouf', 13, 'MIL', 'FRA', 23, '20220001');
INSERT INTO Humain VALUES ('00015','Rabiot','Adrien', 14, 'MIL', 'FRA', 27, '20220001');
INSERT INTO Humain VALUES ('00016','Veretout','Jordan', 15, 'MIL', 'FRA', 29, '20220001');
INSERT INTO Humain VALUES ('00017','Mandanda','Steve', 16, 'GB', 'FRA', 37, '20220001');
INSERT INTO Humain VALUES ('00018','Saliba','William', 17, 'DEF', 'FRA', 21, '20220001');
INSERT INTO Humain VALUES ('00019','Upamecano','Dayot', 18, 'DEF', 'FRA', 24, '20220001');
INSERT INTO Humain VALUES ('00020','Benzema','Karim', 19, 'ATT', 'FRA', 34, '20220001');
INSERT INTO Humain VALUES ('00021','Coman','Kingsley', 20, 'ATT', 'FRA', 26, '20220001');
INSERT INTO Humain VALUES ('00022','Hernandez','Lucas', 21, 'DEF', 'FRA', 26, '20220001');
INSERT INTO Humain VALUES ('00023','Hernandez','Théo', 22, 'DEF', 'FRA', 25, '20220001');
INSERT INTO Humain VALUES ('00024','Areola','Alphonse', 23, 'GB', 'FRA', 29, '20220001');
INSERT INTO Humain VALUES ('00025','Konaté','Ibrahima', 24, 'DEF', 'FRA', 23, '20220001');
INSERT INTO Humain VALUES ('00026','Camavinga','Eduardo', 25, 'MIL', 'FRA', 20, '20220001');
INSERT INTO Humain VALUES ('00027','Thuram','Marcus', 26, 'ATT', 'FRA', 25, '20220001');

INSERT INTO Humain VALUES ('00028','Flick','Hansi', null, 'ENT', 'GER', 57, '20220002');
INSERT INTO Humain VALUES ('00029','Neuer','Manuel', 1, 'GB', 'GER', 36, '20220002');
INSERT INTO Humain VALUES ('00030','Rüdiger','Antonio', 2, 'DEF', 'GER', 29, '20220002');
INSERT INTO Humain VALUES ('00031','Raum','David', 3, 'DEF', 'GER', 24, '20220002');
INSERT INTO Humain VALUES ('00032','Ginter','Matthias', 4, 'DEF', 'GER', 28, '20220002');
INSERT INTO Humain VALUES ('00033','Kehrer','Thilo', 5, 'DEF', 'GER', 26, '20220002');
INSERT INTO Humain VALUES ('00034','Kimmich','Joshua', 6, 'MIL', 'GER', 27, '20220002');
INSERT INTO Humain VALUES ('00035','Havertz','Kai', 7, 'ATT', 'GER', 23, '20220002');
INSERT INTO Humain VALUES ('00036','Goretzka','Leon', 8, 'MIL', 'GER', 27, '20220002');
INSERT INTO Humain VALUES ('00037','Füllkrug','Niclas', 9, 'ATT', 'GER', 29, '20220002');
INSERT INTO Humain VALUES ('00038','Gnabry','Serge', 10, 'MIL', 'GER', 27, '20220002');
INSERT INTO Humain VALUES ('00039','Götze','Mario', 11, 'ATT', 'GER', 29, '20220002');
INSERT INTO Humain VALUES ('00040','Trapp','Kevin', 12, 'GB', 'GER', 32, '20220002');
INSERT INTO Humain VALUES ('00041','Müller','Thomas', 13, 'MIL', 'GER', 33, '20220002');
INSERT INTO Humain VALUES ('00042','Musiala','Jamal', 14, 'MIL', 'GER', 19, '20220002');
INSERT INTO Humain VALUES ('00043','Süle','Niklas', 15, 'DEF', 'GER', 27, '20220002');
INSERT INTO Humain VALUES ('00044','Klostermann','Lukas', 16, 'DEF', 'GER', 26, '20220002');
INSERT INTO Humain VALUES ('00045','Brandt','Julian', 17, 'MIL', 'GER', 26, '20220002');
INSERT INTO Humain VALUES ('00046','Hofmann','Jonas', 18, 'DEF', 'GER', 30, '20220002');
INSERT INTO Humain VALUES ('00047','Sané','Leroy', 19, 'MIL', 'GER', 26, '20220002');
INSERT INTO Humain VALUES ('00048','Günter','Christian', 20, 'DEF', 'GER', 29, '20220002');
INSERT INTO Humain VALUES ('00049','Gündoğan','İlkay', 21, 'MIL', 'GER', 32, '20220002');
INSERT INTO Humain VALUES ('00050','ter Stegen','Marc-André', 22, 'GB', 'GER', 30, '20220002');
INSERT INTO Humain VALUES ('00051','Schlotterbeck','Nico', 23, 'DEF', 'GER', 22, '20220002');
INSERT INTO Humain VALUES ('00052','Adeyemi','Karim', 24, 'ATT', 'GER', 20, '20220002');
INSERT INTO Humain VALUES ('00053','Bella-Kotchap','Armel', 25, 'DEF', 'GER', 20, '20220002');
INSERT INTO Humain VALUES ('00054','Moukoko','Youssoufa', 26, 'ATT', 'GER', 18, '20220002');

INSERT INTO Humain VALUES ('00055','Southgate','Gareth', null, 'ENT', 'ENG', 52, '20220003');
INSERT INTO Humain VALUES ('00056','Pickford','Jordan', 1, 'GB', 'ENG', 28, '20220003');
INSERT INTO Humain VALUES ('00057','Walker','Kyle', 2, 'DEF', 'ENG', 32, '20220003');
INSERT INTO Humain VALUES ('00058','Shaw','Luke', 3, 'DEF', 'ENG', 27, '20220003');
INSERT INTO Humain VALUES ('00059','Rice','Declan', 4, 'MIL', 'ENG', 23, '20220003');
INSERT INTO Humain VALUES ('00060','Stones','John', 5, 'DEF', 'ENG', 28, '20220003');
INSERT INTO Humain VALUES ('00061','Maguire','Harry', 6, 'DEF', 'ENG', 29, '20220003');
INSERT INTO Humain VALUES ('00062','Grealish','Jack', 7, 'ATT', 'ENG', 27, '20220003');
INSERT INTO Humain VALUES ('00063','Henderson','Jordan', 8, 'MIL', 'ENG', 32, '20220003');
INSERT INTO Humain VALUES ('00064','Kane','Harry', 9, 'ATT', 'ENG', 29, '20220003');
INSERT INTO Humain VALUES ('00065','Sterling','Raheem', 10, 'ATT', 'ENG', 27, '20220003');
INSERT INTO Humain VALUES ('00066','Rashford','Marcus', 11, 'ATT', 'ENG', 25, '20220003');
INSERT INTO Humain VALUES ('00067','Trippier','Kieran', 12, 'DEF', 'ENG', 32, '20220003');
INSERT INTO Humain VALUES ('00068','Pope','Nick', 13, 'GB', 'ENG', 30, '20220003');
INSERT INTO Humain VALUES ('00069','Phillips','Kalvin', 14, 'MIL', 'ENG', 26, '20220003');
INSERT INTO Humain VALUES ('00070','Dier','Eric', 15, 'DEF', 'ENG', 28, '20220003');
INSERT INTO Humain VALUES ('00071','Coady','Conor', 16, 'DEF', 'ENG', 29, '20220003');
INSERT INTO Humain VALUES ('00072','Saka','Bukayo', 17, 'ATT', 'ENG', 21, '20220003');
INSERT INTO Humain VALUES ('00073','Alexander-Arnold','Trent', 18, 'DEF', 'ENG', 24, '20220003');
INSERT INTO Humain VALUES ('00074','Mount','Mason', 19, 'MIL', 'ENG', 23, '20220003');
INSERT INTO Humain VALUES ('00075','Foden','Phil', 20, 'MIL', 'ENG', 22, '20220003');
INSERT INTO Humain VALUES ('00076','White','Ben', 21, 'DEF', 'ENG', 25, '20220003');
INSERT INTO Humain VALUES ('00077','Bellingham','Jude', 22, 'MIL', 'ENG', 19, '20220003');
INSERT INTO Humain VALUES ('00078','Ramsdale','Aaron', 23, 'GB', 'ENG', 24, '20220003');
INSERT INTO Humain VALUES ('00079','Wilson','Callum', 24, 'ATT', 'ENG', 30, '20220003');
INSERT INTO Humain VALUES ('00080','Maddison','James', 25, 'MIL', 'ENG', 25, '20220003');
INSERT INTO Humain VALUES ('00081','Gallagher','Conor', 26, 'MIL', 'ENG', 22, '20220003');

INSERT INTO Humain VALUES ('00082','Enrique','Luis', null, 'ENT', 'ESP', 52, '20220004');
INSERT INTO Humain VALUES ('00083','Sánchez','Robert', 1, 'GB', 'ESP', 25, '20220004');
INSERT INTO Humain VALUES ('00084','Azpilicueta','César', 2, 'DEF', 'ESP', 33, '20220004');
INSERT INTO Humain VALUES ('00085','Garcia','Eric', 3, 'DEF', 'ESP', 21, '20220004');
INSERT INTO Humain VALUES ('00086','Torres','Pau', 4, 'DEF', 'ESP', 25, '20220004');
INSERT INTO Humain VALUES ('00087','Busquets','Sergio', 5, 'MIL', 'ESP', 34, '20220004');
INSERT INTO Humain VALUES ('00088','Llorente','Marcos', 6, 'MIL', 'ESP', 27, '20220004');
INSERT INTO Humain VALUES ('00089','Morata','Álvaro', 7, 'ATT', 'ESP', 30, '20220004');
INSERT INTO Humain VALUES ('00090','','Koke', 8, 'MIL', 'ESP', 30, '20220004');
INSERT INTO Humain VALUES ('00091','','Gavi', 9, 'MIL', 'ESP', 18, '20220004');
INSERT INTO Humain VALUES ('00092','Asensio','Marco', 10, 'ATT', 'ESP', 26, '20220004');
INSERT INTO Humain VALUES ('00093','Torres','Ferran', 11, 'ATT', 'ESP', 22, '20220004');
INSERT INTO Humain VALUES ('00094','Williams','Nico', 12, 'ATT', 'ESP', 20, '20220004');
INSERT INTO Humain VALUES ('00095','Raya','David', 13, 'GB', 'ESP', 27, '20220004');
INSERT INTO Humain VALUES ('00096','Gayà','José', 14, 'DEF', 'ESP', 27, '20220004');
INSERT INTO Humain VALUES ('00097','Guillamón','Hugo', 15, 'DEF', 'ESP', 22, '20220004');
INSERT INTO Humain VALUES ('00098','','Rodri', 16, 'MIL', 'ESP', 26, '20220004');
INSERT INTO Humain VALUES ('00099','Pino','Yeremi', 17, 'ATT', 'ESP', 25, '20220004');
INSERT INTO Humain VALUES ('00100','Alba','Jordi', 18, 'DEF', 'ESP', 33, '20220004');
INSERT INTO Humain VALUES ('00101','Soler','Carlos', 19, 'MIL', 'ESP', 25, '20220004');
INSERT INTO Humain VALUES ('00102','Carvajal','Dani', 20, 'DEF', 'ESP', 30, '20220004');
INSERT INTO Humain VALUES ('00103','Olmo','Dani', 21, 'ATT', 'ESP', 24, '20220004');
INSERT INTO Humain VALUES ('00104','Sarabia','Pablo', 22, 'ATT', 'ESP', 30, '20220004');
INSERT INTO Humain VALUES ('00105','Simón','Unai', 23, 'GB', 'ESP', 25, '20220004');
INSERT INTO Humain VALUES ('00106','Laporte','Laporte', 24, 'DEF', 'ESP', 28, '20220004');
INSERT INTO Humain VALUES ('00107','Fati','Ansu', 25, 'ATT', 'ESP', 20, '20220004');
INSERT INTO Humain VALUES ('00108','','Pedri', 26, 'MIL', 'ESP', 19, '20220004');

INSERT INTO Humain VALUES ('00109','','Tite', null, 'ENT', 'BRA', 61, '20220005');
INSERT INTO Humain VALUES ('00110','','Alisson', 1, 'GB', 'BRA', 30, '20220005');
INSERT INTO Humain VALUES ('00111','Luiz','Danilo', 2, 'DEF', 'BRA', 31, '20220005');
INSERT INTO Humain VALUES ('00112','Silva','Thiago', 3, 'DEF', 'BRA', 38, '20220005');
INSERT INTO Humain VALUES ('00113','','Marquinhos', 4, 'DEF', 'BRA', 28, '20220005');
INSERT INTO Humain VALUES ('00114','','Casemiro', 5, 'MIL', 'BRA', 30, '20220005');
INSERT INTO Humain VALUES ('00115','Sandro','Alex', 6, 'DEF', 'BRA', 31, '20220005');
INSERT INTO Humain VALUES ('00116','Paqueta','Lucas', 7, 'MIL', 'BRA', 25, '20220005');
INSERT INTO Humain VALUES ('00117','','Fred', 8, 'MIL', 'BRA', 29, '20220005');
INSERT INTO Humain VALUES ('00118','','Richarlison', 9, 'ATT', 'BRA', 25, '20220005');
INSERT INTO Humain VALUES ('00119','','Neymar', 10, 'ATT', 'BRA', 25, '20220005');
INSERT INTO Humain VALUES ('00120','','Raphinha', 11, 'ATT', 'BRA', 30, '20220005');
INSERT INTO Humain VALUES ('00121','','Weverton', 12, 'GB', 'BRA', 25, '20220005');
INSERT INTO Humain VALUES ('00122','Alves','Daniel', 13, 'DEF', 'BRA', 34, '20220005');
INSERT INTO Humain VALUES ('00123','Militao','Eder', 14, 'DEF', 'BRA', 39, '20220005');
INSERT INTO Humain VALUES ('00124','','Fabinho', 15, 'MIL', 'BRA', 24, '20220005');
INSERT INTO Humain VALUES ('00125','Telles','Alex', 16, 'DEF', 'BRA', 29, '20220005');
INSERT INTO Humain VALUES ('00126','Guimaraes','Bruno', 17, 'MIL', 'BRA', 29, '20220005');
INSERT INTO Humain VALUES ('00127','Jesus','Gabriel', 18, 'ATT', 'BRA', 25, '20220005');
INSERT INTO Humain VALUES ('00128','','Antony', 19, 'ATT', 'BRA', 25, '20220005');
INSERT INTO Humain VALUES ('00129','','Vinicius Jr', 20, 'ATT', 'BRA', 22, '20220005');
INSERT INTO Humain VALUES ('00130','','Rodrygo', 21, 'ATT', 'BRA', 21, '20220005');
INSERT INTO Humain VALUES ('00131','Ribeiro','Everton', 22, 'MIL', 'BRA', 33, '20220005');
INSERT INTO Humain VALUES ('00132','','Ederson', 23, 'GB', 'BRA', 29, '20220005');
INSERT INTO Humain VALUES ('00133','Bremer','Gleison', 24, 'DEF', 'BRA', 25, '20220005');
INSERT INTO Humain VALUES ('00134','dos Santos','Pedro', 25, 'ATT', 'BRA', 25, '20220005');
INSERT INTO Humain VALUES ('00135','Martinelli','Gabriel', 26, 'ATT', 'BRA', 21, '20220005');

INSERT INTO Humain VALUES ('00136','Dalic','Zlatko', null, 'ENT', 'CRO', 56, '20220006');
INSERT INTO Humain VALUES ('00137','Livakovic','Dominik', 1, 'GB', 'CRO', 27, '20220006');
INSERT INTO Humain VALUES ('00138','Stanisic','Josip', 2, 'DEF', 'CRO', 22, '20220006');
INSERT INTO Humain VALUES ('00139','Barisic','Borna', 3, 'DEF', 'CRO', 30, '20220006');
INSERT INTO Humain VALUES ('00140','Perisic','Ivan', 4, 'ATT', 'CRO', 33, '20220006');
INSERT INTO Humain VALUES ('00141','Erlic','Martin', 5, 'DEF', 'CRO', 24, '20220006');
INSERT INTO Humain VALUES ('00142','Lovren','Dejan', 6, 'DEF', 'CRO', 33, '20220006');
INSERT INTO Humain VALUES ('00143','Majer','Lovro', 7, 'MIL', 'CRO', 24, '20220006');
INSERT INTO Humain VALUES ('00144','Kovacic','Mateo', 8, 'MIL', 'CRO', 28, '20220006');
INSERT INTO Humain VALUES ('00145','Kramaric','Andrej', 9, 'ATT', 'CRO', 31, '20220006');
INSERT INTO Humain VALUES ('00146','Modric','Luka', 10, 'MIL', 'CRO', 37, '20220006');
INSERT INTO Humain VALUES ('00147','Brozovic','Marcelo', 11, 'MIL', 'CRO', 30, '20220006');
INSERT INTO Humain VALUES ('00148','Grbic','Ivo', 12, 'GB', 'CRO', 26, '20220006');
INSERT INTO Humain VALUES ('00149','Vlasic','Nikola', 13, 'MIL', 'CRO', 25, '20220006');
INSERT INTO Humain VALUES ('00150','Livaja','Marko', 14, 'ATT', 'CRO', 29, '20220006');
INSERT INTO Humain VALUES ('00151','Pasalic','Mario', 15, 'MIL', 'CRO', 27, '20220006');
INSERT INTO Humain VALUES ('00152','Petkovic','Bruno', 16, 'ATT', 'CRO', 28, '20220006');
INSERT INTO Humain VALUES ('00153','Budimir','Ante', 17, 'ATT', 'CRO', 31, '20220006');
INSERT INTO Humain VALUES ('00154','Orsic','Mislav', 18, 'ATT', 'CRO', 29, '20220006');
INSERT INTO Humain VALUES ('00155','Sosa','Borna', 19, 'DEF', 'CRO', 24, '20220006');
INSERT INTO Humain VALUES ('00156','Gvardiol','Josko', 20, 'DEF', 'CRO', 20, '20220006');
INSERT INTO Humain VALUES ('00157','Vida','Domagoj', 21, 'DEF', 'CRO', 33, '20220006');
INSERT INTO Humain VALUES ('00158','Juranovic','Josip', 22, 'DEF', 'CRO', 27, '20220006');  
INSERT INTO Humain VALUES ('00159','Ivusic','Ivica', 23, 'GB', 'CRO', 27, '20220006');
INSERT INTO Humain VALUES ('00160','Sutalo','Josip', 24, 'DEF', 'CRO', 22, '20220006');
INSERT INTO Humain VALUES ('00161','Sucic','Luka', 25, 'MIL', 'CRO', 20, '20220006');
INSERT INTO Humain VALUES ('00162','Jakic','Kristijan', 26, 'MIL', 'CRO', 25, '20220006');

INSERT INTO Humain VALUES ('00163','Martino','Gerardo', null, 'ENT', 'ARG', 60, '20220007');
INSERT INTO Humain VALUES ('00164','Talavera','Alfredo', 1, 'GB', 'MEX', 40, '20220007');
INSERT INTO Humain VALUES ('00165','Araujo','Nestor', 2, 'DEF', 'MEX', 31, '20220007');
INSERT INTO Humain VALUES ('00166','Montes','César', 3, 'DEF', 'MEX', 25, '20220007');
INSERT INTO Humain VALUES ('00167','Alvarez','Edson', 4, 'MIL', 'MEX', 25, '20220007');
INSERT INTO Humain VALUES ('00168','Vásquez','Johan', 5, 'DEF', 'MEX', 24, '20220007');
INSERT INTO Humain VALUES ('00169','Arteaga','Gerardo', 6, 'DEF', 'MEX', 24, '20220007');
INSERT INTO Humain VALUES ('00170','Romo','Luis', 7, 'MIL', 'MEX', 27, '20220007');
INSERT INTO Humain VALUES ('00171','Rodriguez','Carlos', 8, 'MIL', 'MEX', 25, '20220007');
INSERT INTO Humain VALUES ('00172','Raul','Jimenez', 9, 'ATT', 'MEX', 31, '20220007');
INSERT INTO Humain VALUES ('00173','Vega','Alexis', 10, 'ATT', 'MEX', 24, '20220007');
INSERT INTO Humain VALUES ('00174','Funes Mori','Rogelio', 11, 'ATT', 'MEX', 31, '20220007');
INSERT INTO Humain VALUES ('00175','Cota','Rodolfo', 12, 'GB', 'MEX', 35, '20220007');
INSERT INTO Humain VALUES ('00176','Ochoa','Guillermo', 13, 'GB', 'MEX', 37, '20220007');
INSERT INTO Humain VALUES ('00177','Gutiérrez','Erick', 14, 'MIL', 'MEX', 27, '20220007');
INSERT INTO Humain VALUES ('00178','Moreno','Hector', 15, 'DEF', 'MEX', 34, '20220007');
INSERT INTO Humain VALUES ('00179','Herrera','Hector', 16, 'MIL', 'MEX', 32, '20220007');
INSERT INTO Humain VALUES ('00180','Pineda','Orbelín', 17, 'ATT', 'MEX', 26, '20220007');
INSERT INTO Humain VALUES ('00181','Guardado','Andres', 18, 'MIL', 'MEX', 36, '20220007');
INSERT INTO Humain VALUES ('00182','Sánchez','Jorge', 19, 'DEF', 'MEX', 24, '20220007');
INSERT INTO Humain VALUES ('00183','Martin','Henry', 20, 'ATT', 'MEX', 30, '20220007');
INSERT INTO Humain VALUES ('00184','Antuna','Uriel', 21, 'ATT', 'MEX', 25, '20220007');
INSERT INTO Humain VALUES ('00185','Lozano','Hirving', 22, 'ATT', 'MEX', 27, '20220007');  
INSERT INTO Humain VALUES ('00186','Gallardo','Jesus', 23, 'DEF', 'MEX', 28, '20220007');
INSERT INTO Humain VALUES ('00187','Chavez','Luis', 24, 'MIL', 'MEX', 26, '20220007');
INSERT INTO Humain VALUES ('00188','Alvarado','Roberto', 25, 'ATT', 'MEX', 24, '20220007');
INSERT INTO Humain VALUES ('00189','Alvarez','Kevin', 26, 'DEF', 'MEX', 23, '20220007');

INSERT INTO Humain VALUES ('00190','Song','Rigobert', null, 'ENT', 'CMR', 46, '20220008');
INSERT INTO Humain VALUES ('00191','Ngapandouetnbu','Simon', 1, 'GB', 'CMR', 19, '20220008');
INSERT INTO Humain VALUES ('00192','Ngom','Jerome', 2, 'DEF', 'CMR', 24, '20220008');
INSERT INTO Humain VALUES ('00193','Nkoulou','Nicolas', 3, 'DEF', 'CMR', 32, '20220008');
INSERT INTO Humain VALUES ('00194','Wooh','Christopher', 4, 'DEF', 'CMR', 21, '20220008');
INSERT INTO Humain VALUES ('00195','Ondoua','Gael', 5, 'MIL', 'CMR', 27, '20220008');
INSERT INTO Humain VALUES ('00196','Ngamaleu','Nicolas', 6, 'ATT', 'CMR', 28, '20220008');
INSERT INTO Humain VALUES ('00197','Nkoudou','Georges-Kevin', 7, 'MIL', 'CMR', 27, '20220008');
INSERT INTO Humain VALUES ('00198','Anguissa','Franck Zambo', 8, 'MIL', 'CMR', 27, '20220008');
INSERT INTO Humain VALUES ('00199','Nsame','Jean-Pierre', 9, 'ATT', 'CMR', 29, '20220008');
INSERT INTO Humain VALUES ('00200','Aboubakar','Vincent', 10, 'ATT', 'CMR', 30, '20220008');
INSERT INTO Humain VALUES ('00201','Bassogog','Christian', 11, 'ATT', 'CMR', 27, '20220008');
INSERT INTO Humain VALUES ('00202','Toko-Ekambi','Karl', 12, 'ATT', 'CMR', 30, '20220008');
INSERT INTO Humain VALUES ('00203','Choupo-Moting','Eric', 13, 'ATT', 'CMR', 33, '20220008');
INSERT INTO Humain VALUES ('00204','Gouet','Samuel', 14, 'MIL', 'CMR', 24, '20220008');
INSERT INTO Humain VALUES ('00205','Kunde','Pierre', 15, 'MIL', 'CMR', 27, '20220008');
INSERT INTO Humain VALUES ('00206','Epassy','Devis', 16, 'GB', 'CMR', 29, '20220008');
INSERT INTO Humain VALUES ('00207','Mbaizo','Olivier', 17, 'DEF', 'CMR', 25, '20220008');
INSERT INTO Humain VALUES ('00208','Hongla','Martin', 18, 'MIL', 'CMR', 24, '20220008');
INSERT INTO Humain VALUES ('00209','Fai','Collins', 19, 'DEF', 'CMR', 30, '20220008');
INSERT INTO Humain VALUES ('00210','Mbeumo','Bryan', 20, 'ATT', 'CMR', 23, '20220008');
INSERT INTO Humain VALUES ('00211','Castelletto','Jean-Charles', 21, 'DEF', 'CMR', 27, '20220008');
INSERT INTO Humain VALUES ('00212','Ntcham','Olivier', 22, 'MIL', 'CMR', 26, '20220008');  
INSERT INTO Humain VALUES ('00213','Onana','André', 23, 'GB', 'CMR', 26, '20220008');
INSERT INTO Humain VALUES ('00214','Ebosse','Enzo', 24, 'DEF', 'CMR', 23, '20220008');
INSERT INTO Humain VALUES ('00215','Tolo','Nouhou', 25, 'DEF', 'CMR', 25, '20220008');
INSERT INTO Humain VALUES ('00216','Marou','Souaibou', 26, 'MIL', 'CMR', 21, '20220008');

INSERT INTO Humain VALUES ('00217','Van Gaal','Louis', null, 'ENT', 'NED', 71, '20220009');
INSERT INTO Humain VALUES ('00218','Pasveer','Remko', 1, 'GB', 'NED', 39, '20220009');
INSERT INTO Humain VALUES ('00219','Timber','Jurriën', 2, 'DEF', 'NED', 21, '20220009');
INSERT INTO Humain VALUES ('00220','de Ligt','Matthijs', 3, 'DEF', 'NED', 23, '20220009');
INSERT INTO Humain VALUES ('00221','van Dijk','Virgil', 4, 'DEF', 'NED', 31, '20220009');
INSERT INTO Humain VALUES ('00222','Aké','Nathan', 5, 'DEF', 'NED', 27, '20220009');
INSERT INTO Humain VALUES ('00223','de Vrij','Stefan', 6, 'DEF', 'NED', 30, '20220009');
INSERT INTO Humain VALUES ('00224','Bergwijn','Steven', 7, 'ATT', 'NED', 25, '20220009');
INSERT INTO Humain VALUES ('00225','Gakpo','Cody', 8, 'ATT', 'NED', 23, '20220009');
INSERT INTO Humain VALUES ('00226','de Jong','Luuk', 9, 'ATT', 'NED', 32, '20220009');
INSERT INTO Humain VALUES ('00227','Depay','Memphis', 10, 'ATT', 'NED', 28, '20220009');
INSERT INTO Humain VALUES ('00228','Berghuis','Steven', 11, 'MIL', 'NED', 30, '20220009');
INSERT INTO Humain VALUES ('00229','Lang','Noa', 12, 'ATT', 'NED', 23, '20220009');
INSERT INTO Humain VALUES ('00230','Bijlow','Justin', 13, 'GB', 'NED', 24, '20220009');
INSERT INTO Humain VALUES ('00231','Klaassen','Davy', 14, 'MIL', 'NED', 29, '20220009');
INSERT INTO Humain VALUES ('00232','de Roon','Marten', 15, 'MIL', 'NED', 31, '20220009');
INSERT INTO Humain VALUES ('00233','Malacia','Tyrell', 16, 'DEF', 'NED', 23, '20220009');
INSERT INTO Humain VALUES ('00234','Blind','Daley', 17, 'DEF', 'NED', 32, '20220009');
INSERT INTO Humain VALUES ('00235','Janssen','Vincent', 18, 'ATT', 'NED', 28, '20220009');
INSERT INTO Humain VALUES ('00236','Weghorst','Wout', 19, 'ATT', 'NED', 30, '20220009');
INSERT INTO Humain VALUES ('00237','Koopmeiners','Teun', 20, 'MIL', 'NED', 54, '20220009');
INSERT INTO Humain VALUES ('00238','de Jong','Frenkie', 21, 'MIL', 'NED', 25, '20220009');
INSERT INTO Humain VALUES ('00239','Dumfries','Denzel', 22, 'DEF', 'NED', 26, '20220009');  
INSERT INTO Humain VALUES ('00240','Noppert','Andries', 23, 'GB', 'NED', 28, '20220009');
INSERT INTO Humain VALUES ('00241','Taylor','Kenneth', 24, 'MIL', 'NED', 20, '20220009');
INSERT INTO Humain VALUES ('00242','Simons','Xavi', 25, 'MIL', 'NED', 19, '20220009');
INSERT INTO Humain VALUES ('00243','Frimpong','Jeremie', 26, 'DEF', 'NED', 21, '20220009');

INSERT INTO Humain VALUES ('00244','Arnold','Graham', null, 'ENT', 'AUS', 58, '20220010');
INSERT INTO Humain VALUES ('00245','Ryan','Mathew', 1, 'GB', 'AUS', 30, '20220010');
INSERT INTO Humain VALUES ('00246','Degenek','Milos', 2, 'DEF', 'AUS', 28, '20220010');
INSERT INTO Humain VALUES ('00247','Atkinson','Nathaniel', 3, 'DEF', 'AUS', 23, '20220010');
INSERT INTO Humain VALUES ('00248','Rowles','Kye', 4, 'DEF', 'AUS', 24, '20220010');
INSERT INTO Humain VALUES ('00249','Karacic','Fran', 5, 'DEF', 'AUS', 26, '20220010');
INSERT INTO Humain VALUES ('00250','Boyle','Martin', 6, 'ATT', 'AUS', 29, '20220010');
INSERT INTO Humain VALUES ('00251','Leckie','Matthew', 7, 'ATT', 'AUS', 31, '20220010');
INSERT INTO Humain VALUES ('00252','Wright','Bailey', 8, 'DEF', 'AUS', 30, '20220010');
INSERT INTO Humain VALUES ('00253','MacLaren','Jamie', 9, 'ATT', 'AUS', 29, '20220010');
INSERT INTO Humain VALUES ('00254','Hrustic','Ajdin', 10, 'MIL', 'AUS', 26, '20220010');
INSERT INTO Humain VALUES ('00255','Mabil','Awer', 11, 'ATT', 'AUS', 27, '20220010');
INSERT INTO Humain VALUES ('00256','Redmayne','Andrew', 12, 'GB', 'AUS', 33, '20220010');
INSERT INTO Humain VALUES ('00257','Mooy','Aaron', 13, 'MIL', 'AUS', 32, '20220010');
INSERT INTO Humain VALUES ('00258','McGree','Riley', 14, 'MIL', 'AUS', 24, '20220010');
INSERT INTO Humain VALUES ('00259','Duke','Mitchell', 15, 'ATT', 'AUS', 31, '20220010');
INSERT INTO Humain VALUES ('00260','Behich','Aziz', 16, 'DEF', 'AUS', 31, '20220010');
INSERT INTO Humain VALUES ('00261','Devlin','Cameron', 17, 'MIL', 'AUS', 24, '20220010');
INSERT INTO Humain VALUES ('00262','Vukovic','Daniel', 18, 'GB', 'AUS', 35, '20220010');
INSERT INTO Humain VALUES ('00263','Souttar','Harry', 19, 'DEF', 'AUS', 24, '20220010');
INSERT INTO Humain VALUES ('00264','Deng','Thomas', 20, 'DEF', 'AUS', 25, '20220010');
INSERT INTO Humain VALUES ('00265','Kuol','Garang', 21, 'ATT', 'AUS', 18, '20220010');
INSERT INTO Humain VALUES ('00266','Irvine','Jackson', 22, 'MIL', 'AUS', 29, '20220010');  
INSERT INTO Humain VALUES ('00267','Goodwin','Craig', 23, 'ATT', 'AUS', 30, '20220010');
INSERT INTO Humain VALUES ('00268','King','Joel', 24, 'DEF', 'AUS', 22, '20220010');
INSERT INTO Humain VALUES ('00269','Cummings','Jason', 25, 'ATT', 'AUS', 27, '20220010');
INSERT INTO Humain VALUES ('00270','Baccus','Keanu', 26, 'MIL', 'AUS', 24, '20220010');

INSERT INTO Humain VALUES ('00271','Arnold','Graham', null, 'ENT', 'URU', 47, '20220011');
INSERT INTO Humain VALUES ('00272','Muslera','Fernando', 1, 'GB', 'URU', 24, '20220011');
INSERT INTO Humain VALUES ('00273','Giménez','José Maria', 2, 'DEF', 'URU', 23, '20220011');
INSERT INTO Humain VALUES ('00274','Godín','Diego', 3, 'DEF', 'URU', 36, '20220011');
INSERT INTO Humain VALUES ('00275','Araujo','Ronald', 4, 'DEF', 'URU', 35, '20220011');
INSERT INTO Humain VALUES ('00276','Vecino','Matias', 5, 'MIL', 'URU', 20, '20220011');
INSERT INTO Humain VALUES ('00277','Bentancur','Rodrigo', 6, 'MIL', 'URU', 22, '20220011');
INSERT INTO Humain VALUES ('00278','de la Cruz','Nicolas', 7, 'MIL', 'URU', 24, '20220011');
INSERT INTO Humain VALUES ('00279','Pellistri','Facundo', 8, 'MIL', 'URU', 36, '20220011');
INSERT INTO Humain VALUES ('00280','Suárez','Luis', 9, 'ATT', 'URU', 28, '20220011');
INSERT INTO Humain VALUES ('00281','De Arrascaeta','Giorgian', 10, 'MIL', 'URU', 29, '20220011');
INSERT INTO Humain VALUES ('00282','Nunez','Darwin', 11, 'ATT', 'URU', 25, '20220011');
INSERT INTO Humain VALUES ('00283','Sosa','Sebastian', 12, 'GB', 'URU', 27, '20220011');
INSERT INTO Humain VALUES ('00284','Varela','Guillermo', 13, 'DEF', 'URU', 26, '20220011');
INSERT INTO Humain VALUES ('00285','Torreira','Lucas', 14, 'MIL', 'URU', 35, '20220011');
INSERT INTO Humain VALUES ('00286','Valverde','Federico', 15, 'MIL', 'URU', 21, '20220011');
INSERT INTO Humain VALUES ('00287','Olivera','Mathias', 16, 'DEF', 'URU', 35, '20220011');
INSERT INTO Humain VALUES ('00288','Vina','Matias', 17, 'DEF', 'URU', 25, '20220011');
INSERT INTO Humain VALUES ('00289','Gomez','Maximiliano', 18, 'ATT', 'URU', 31, '20220011');
INSERT INTO Humain VALUES ('00290','Coates','Sebastián', 19, 'DEF', 'URU', 35, '20220011');
INSERT INTO Humain VALUES ('00291','Torres','Facundo', 20, 'MIL', 'URU', 36, '20220011');
INSERT INTO Humain VALUES ('00292','Cavani','Edinson', 21, 'ATT', 'URU', 25, '20220011');
INSERT INTO Humain VALUES ('00293','Cáceres','Martín', 22, 'DEF', 'URU', 25, '20220011');  
INSERT INTO Humain VALUES ('00294','Rochet','Sergio', 23, 'GB', 'URU', 23, '20220011');
INSERT INTO Humain VALUES ('00295','Canobbio','Agustin', 24, 'MIL', 'URU', 32, '20220011');
INSERT INTO Humain VALUES ('00296','Ugarte','Manuel', 25, 'MIL', 'URU', 36, '20220011');
INSERT INTO Humain VALUES ('00297','Rodríguez','Jose', 26, 'DEF', 'URU', 29, '20220011');

INSERT INTO Humain VALUES ('00298','Suárez','Luis Fernando', null, 'ENT', 'Colombie', 62, '20220012');
INSERT INTO Humain VALUES ('00299','Navas','Keylor', 1, 'GB', 'CRC', 35, '20220012');
INSERT INTO Humain VALUES ('00300','Chacon','Daniel', 2, 'MIL', 'CRC', 21, '20220012');
INSERT INTO Humain VALUES ('00301','Pablo Vargas','Juan', 3, 'DEF', 'CRC', 27, '20220012');
INSERT INTO Humain VALUES ('00302','Fuller','Keysher', 4, 'DEF', 'CRC', 28, '20220012');
INSERT INTO Humain VALUES ('00303','Borges','Celso', 5, 'MIL', 'CRC', 34, '20220012');
INSERT INTO Humain VALUES ('00304','Duarte','Oscar', 6, 'DEF', 'CRC', 33, '20220012');
INSERT INTO Humain VALUES ('00305','Contreras','Anthony', 7, 'ATT', 'CRC', 22, '20220012');
INSERT INTO Humain VALUES ('00306','Oviedo','Bryan', 8, 'DEF', 'CRC', 32, '20220012');
INSERT INTO Humain VALUES ('00307','Bennette','Jewison', 9, 'MIL', 'CRC', 18, '20220012');
INSERT INTO Humain VALUES ('00308','Ruiz','Bryan', 10, 'MIL', 'CRC', 35, '20220012');
INSERT INTO Humain VALUES ('00309','Venegas','Johan', 11, 'ATT', 'CRC', 33, '20220012');
INSERT INTO Humain VALUES ('00310','Campbell','Joel', 12, 'ATT', 'CRC', 30, '20220012');
INSERT INTO Humain VALUES ('00311','Torres','Gerson', 13, 'MIL', 'CRC', 25, '20220012');
INSERT INTO Humain VALUES ('00312','Salas','Youstin', 14, 'MIL', 'CRC', 26, '20220012');
INSERT INTO Humain VALUES ('00313','Calvo','Francisco', 15, 'DEF', 'CRC', 30, '20220012');
INSERT INTO Humain VALUES ('00314','Martinez','Carlos', 16, 'DEF', 'CRC', 23, '20220012');
INSERT INTO Humain VALUES ('00315','Tejeda','Yeltsin', 17, 'MIL', 'CRC', 30, '20220012');
INSERT INTO Humain VALUES ('00316','Alvarado','Esteban', 18, 'GB', 'CRC', 33, '20220012');
INSERT INTO Humain VALUES ('00317','Waston','Kendall', 19, 'DEF', 'CRC', 34, '20220012');
INSERT INTO Humain VALUES ('00318','Aguilera','Brandon', 20, 'MIL', 'CRC', 19, '20220012');
INSERT INTO Humain VALUES ('00319','Lopez','Douglas', 21, 'MIL', 'CRC', 24, '20220012');
INSERT INTO Humain VALUES ('00320','Matarrita','Ronald', 22, 'DEF', 'CRC', 28, '20220012');  
INSERT INTO Humain VALUES ('00321','Sequeira','Patrick', 23, 'GB', 'CRC', 23, '20220012');
INSERT INTO Humain VALUES ('00322','Wilson','Roan', 24, 'MIL', 'CRC', 20, '20220012');
INSERT INTO Humain VALUES ('00323','Hernandez','Anthony', 25, 'MIL', 'CRC', 21, '20220012');
INSERT INTO Humain VALUES ('00324','Zamora','Alvaro', 26, 'MIL', 'CRC', 20, '20220012');

INSERT INTO Humain VALUES ('00325','Moriyasu','Hajime', null, 'ENT', 'JAP', 54, '20220013');
INSERT INTO Humain VALUES ('00326','Kawashima','Eiji', 1, 'GB', 'JAP', 39, '20220013');
INSERT INTO Humain VALUES ('00327','Yamane','Miki', 2, 'DEF', 'JAP', 28, '20220013');
INSERT INTO Humain VALUES ('00328','Taniguchi','Shogo', 3, 'DEF', 'JAP', 31, '20220013');
INSERT INTO Humain VALUES ('00329','Itakura','Ko', 4, 'DEF', 'JAP', 25, '20220013');
INSERT INTO Humain VALUES ('00330','Nagatomo','Yuto', 5, 'DEF', 'JAP', 36, '20220013');
INSERT INTO Humain VALUES ('00331','Endo','Wataru', 6, 'MIL', 'JAP', 29, '20220013');
INSERT INTO Humain VALUES ('00332','Shibasaki','Gaku', 7, 'MIL', 'JAP', 30, '20220013');
INSERT INTO Humain VALUES ('00333','Doan','Ritsu', 8, 'ATT', 'JAP', 24, '20220013');
INSERT INTO Humain VALUES ('00334','Mitoma','Kaoru', 9, 'ATT', 'JAP', 25, '20220013');
INSERT INTO Humain VALUES ('00335','Minamino','Takumi', 10, 'ATT', 'JAP', 27, '20220013');
INSERT INTO Humain VALUES ('00336','Kubo','Takefusa', 11, 'ATT', 'JAP', 21, '20220013');
INSERT INTO Humain VALUES ('00337','Gonda','Shuichi', 12, 'GB', 'JAP', 33, '20220013');
INSERT INTO Humain VALUES ('00338','Morita','Hidemasa', 13, 'MIL', 'JAP', 27, '20220013');
INSERT INTO Humain VALUES ('00339','Ito','Junya', 14, 'ATT', 'JAP', 29, '20220013');
INSERT INTO Humain VALUES ('00340','Kamada','Daichi', 15, 'MIL', 'JAP', 26, '20220013');
INSERT INTO Humain VALUES ('00341','Tomiyasu','Takehiro', 16, 'DEF', 'JAP', 24, '20220013');
INSERT INTO Humain VALUES ('00342','Tanaka','Ao', 17, 'MIL', 'JAP', 24, '20220013');
INSERT INTO Humain VALUES ('00343','Asano','Takuma', 18, 'ATT', 'JAP', 28, '20220013');
INSERT INTO Humain VALUES ('00344','Sakai','Hiroki', 19, 'DEF', 'JAP', 32, '20220013');
INSERT INTO Humain VALUES ('00345','Machino','Shuto', 20, 'ATT', 'JAP', 23, '20220013');
INSERT INTO Humain VALUES ('00346','Ueda','Ayase', 21, 'ATT', 'JAP', 24, '20220013');
INSERT INTO Humain VALUES ('00347','Yoshida','Maya', 22, 'DEF', 'JAP', 34, '20220013');  
INSERT INTO Humain VALUES ('00348','Schmidt','Daniel', 23, 'GB', 'JAP', 30, '20220013');
INSERT INTO Humain VALUES ('00349','Soma','Yuki', 24, 'ATT', 'JAP', 25, '20220013');
INSERT INTO Humain VALUES ('00350','Maeda','Daizen', 25, 'ATT', 'JAP', 25, '20220013');
INSERT INTO Humain VALUES ('00351','Ito','Hiroki', 26, 'DEF', 'JAP', 23, '20220013');

INSERT INTO Humain VALUES ('00352','Yakin','Murat', null, 'ENT', 'SUI', 48, '20220014');
INSERT INTO Humain VALUES ('00353','Sommer','Yann', 1, 'GB', 'SUI', 33, '20220014');
INSERT INTO Humain VALUES ('00354','Fernandes','Edimilson', 2, 'DEF', 'SUI', 26, '20220014');
INSERT INTO Humain VALUES ('00355','Widmer','Silvan', 3, 'DEF', 'SUI', 29, '20220014');
INSERT INTO Humain VALUES ('00356','Elvedi','Nico', 4, 'DEF', 'SUI', 26, '20220014');
INSERT INTO Humain VALUES ('00357','Akanji','Manuel', 5, 'DEF', 'SUI', 27, '20220014');
INSERT INTO Humain VALUES ('00358','Zakaria','Denis', 6, 'MIL', 'SUI', 26, '20220014');
INSERT INTO Humain VALUES ('00359','Embolo','Breel', 7, 'ATT', 'SUI', 25, '20220014');
INSERT INTO Humain VALUES ('00360','Freuler','Remo', 8, 'MIL', 'SUI', 30, '20220014');
INSERT INTO Humain VALUES ('00361','Seferovic','Haris', 9, 'ATT', 'SUI', 30, '20220014');
INSERT INTO Humain VALUES ('00362','Xhaka','Granit', 10, 'MIL', 'SUI', 30, '20220014');
INSERT INTO Humain VALUES ('00363','Steffen','Renato', 11, 'ATT', 'SUI', 31, '20220014');
INSERT INTO Humain VALUES ('00364','Omlin','Jonas', 12, 'GB', 'SUI', 28, '20220014');
INSERT INTO Humain VALUES ('00365','Rodriguez','Ricardo', 13, 'DEF', 'SUI', 30, '20220014');
INSERT INTO Humain VALUES ('00366','Aebischer','Michel', 14, 'MIL', 'SUI', 25, '20220014');
INSERT INTO Humain VALUES ('00367','Sow','Djibril', 15, 'MIL', 'SUI', 25, '20220014');
INSERT INTO Humain VALUES ('00368','Fassnacht','Christian', 16, 'MIL', 'SUI', 29, '20220014');
INSERT INTO Humain VALUES ('00369','Vargas','Ruben', 17, 'ATT', 'SUI', 24, '20220014');
INSERT INTO Humain VALUES ('00370','Cömert','Eray', 18, 'DEF', 'SUI', 24, '20220014');
INSERT INTO Humain VALUES ('00371','Okafor','Noah', 19, 'ATT', 'SUI', 22, '20220014');
INSERT INTO Humain VALUES ('00372','Frei','Fabian', 20, 'MIL', 'SUI', 33, '20220014');
INSERT INTO Humain VALUES ('00373','Kobel','Gregor', 21, 'GB', 'SUI', 24, '20220014');
INSERT INTO Humain VALUES ('00374','Schär','Fabian', 22, 'DEF', 'SUI', 30, '20220014');  
INSERT INTO Humain VALUES ('00375','Shaqiri','Xherdan', 23, 'MIL', 'SUI', 31, '20220014');
INSERT INTO Humain VALUES ('00376','Kohn','Philipp', 24, 'GB', 'SUI', 24, '20220014');
INSERT INTO Humain VALUES ('00377','Rieder','FabiaN', 25, 'MIL', 'SUI', 20, '20220014');
INSERT INTO Humain VALUES ('00378','Jashari','Ardon', 26, 'MIL', 'SUI', 20, '20220014');

INSERT INTO Humain VALUES ('00379','Alfaro','Gustavo', null, 'ENT', 'ARG', 60, '20220015');
INSERT INTO Humain VALUES ('00380','Galindez','Hernan', 1, 'GB', 'ECU', 35, '20220015');
INSERT INTO Humain VALUES ('00381','Torres','Félix', 2, 'DEF', 'ECU', 25, '20220015');
INSERT INTO Humain VALUES ('00382','Hincapié','Piero', 3, 'DEF', 'ECU', 20, '20220015');
INSERT INTO Humain VALUES ('00383','Arboleda','Robert', 4, 'DEF', 'ECU', 31, '20220015');
INSERT INTO Humain VALUES ('00384','Cifuentes','José', 5, 'MIL', 'ECU', 23, '20220015');
INSERT INTO Humain VALUES ('00385','Pacho','William', 6, 'DEF', 'ECU', 21, '20220015');
INSERT INTO Humain VALUES ('00386','Estupinan','Pervis', 7, 'DEF', 'ECU', 24, '20220015');
INSERT INTO Humain VALUES ('00387','Gruezo','Carlos', 8, 'MIL', 'ECU', 27, '20220015');
INSERT INTO Humain VALUES ('00388','Preciado','Ayrton', 9, 'MIL', 'ECU', 28, '20220015');
INSERT INTO Humain VALUES ('00389','Ibarra','Romario', 10, 'MIL', 'ECU', 28, '20220015');
INSERT INTO Humain VALUES ('00390','Estrada','Michael', 11, 'ATT', 'ECU', 26, '20220015');
INSERT INTO Humain VALUES ('00391','Ramirez','Moisés', 12, 'GB', 'ECU', 22, '20220015');
INSERT INTO Humain VALUES ('00392','Valencia','Enner', 13, 'ATT', 'ECU', 33, '20220015');
INSERT INTO Humain VALUES ('00393','Arreaga','Xavier', 14, 'DEF', 'ECU', 28, '20220015');
INSERT INTO Humain VALUES ('00394','Mena','Angel', 15, 'MIL', 'ECU', 34, '20220015');
INSERT INTO Humain VALUES ('00395','Sarmiento','Jeremy', 16, 'MIL', 'ECU', 20, '20220015');
INSERT INTO Humain VALUES ('00396','Preciado','Angelo', 17, 'DEF', 'ECU', 24, '20220015');
INSERT INTO Humain VALUES ('00397','Palacios','Diego', 18, 'DEF', 'ECU', 23, '20220015');
INSERT INTO Humain VALUES ('00398','Plata','Gonzalo', 19, 'MIL', 'ECU', 22, '20220015');
INSERT INTO Humain VALUES ('00399','Méndez','Jhegson', 20, 'MIL', 'ECU', 25, '20220015');
INSERT INTO Humain VALUES ('00400','Franco','Alan', 21, 'MIL', 'ECU', 24, '20220015');
INSERT INTO Humain VALUES ('00401','Dominguez','Alexander', 22, 'GB', 'ECU', 35, '20220015');  
INSERT INTO Humain VALUES ('00402','Caicedo','Moisés', 23, 'MIL', 'ECU', 21, '20220015');
INSERT INTO Humain VALUES ('00403','Reasco','Djorkaeff', 24, 'ATT', 'ECU', 23, '20220015');
INSERT INTO Humain VALUES ('00404','Porozo','Jackson', 25, 'DEF', 'ECU', 22, '20220015');
INSERT INTO Humain VALUES ('00405','Rodriguez','Kevin', 26, 'ATT', 'ECU', 22, '20220015');

INSERT INTO Humain VALUES ('00406','Queiroz','Carlos', null, 'ENT', 'POR', 69, '20220017');
INSERT INTO Humain VALUES ('00407','BeIRNvand','Alireza', 1, 'GB', 'IRN', 30, '20220017');
INSERT INTO Humain VALUES ('00408','Moharrami','Sadegh', 2, 'DEF', 'IRN', 26, '20220017'); 
INSERT INTO Humain VALUES ('00409','Hajsafi','Ehsan', 3, 'DEF', 'IRN', 32, '20220017');
INSERT INTO Humain VALUES ('00410','Khalilzadeh','Shojae', 4, 'DEF', 'IRN', 33, '20220017');
INSERT INTO Humain VALUES ('00411','Mohammadi','Milad', 5, 'DEF', 'IRN', 29, '20220017');
INSERT INTO Humain VALUES ('00412','Ezatolahi','Saeid', 6, 'MIL', 'IRN', 26, '20220017');
INSERT INTO Humain VALUES ('00413','Jahanbakhsh','Alireza', 7, 'MIL', 'IRN', 29, '20220017');
INSERT INTO Humain VALUES ('00414','Pouraliganji','Morteza', 8, 'DEF', 'IRN', 30, '20220017');
INSERT INTO Humain VALUES ('00415','Taremi','Mehdi', 9, 'ATT', 'IRN', 30, '20220017');
INSERT INTO Humain VALUES ('00416','Ansarifard','Karim', 10, 'ATT', 'IRN', 32, '20220017');
INSERT INTO Humain VALUES ('00417','Amiri','Vahid', 11, 'MIL', 'IRN', 34, '20220017');
INSERT INTO Humain VALUES ('00418','Niazmand','Payam', 12, 'GB', 'IRN', 27, '20220017');
INSERT INTO Humain VALUES ('00419','Kanani','Hossein', 13, 'DEF', 'IRN', 28, '20220017');
INSERT INTO Humain VALUES ('00420','Ghoddos','Saman', 14, 'MIL', 'IRN', 29, '20220017');
INSERT INTO Humain VALUES ('00421','Cheshmi','Rouzbeh', 15, 'DEF', 'IRN', 29, '20220017');
INSERT INTO Humain VALUES ('00422','Torabi','Mehdi', 16, 'MIL', 'IRN', 28, '20220017');
INSERT INTO Humain VALUES ('00423','Gholizadeh','Ali', 17, 'MIL', 'IRN', 26, '20220017');
INSERT INTO Humain VALUES ('00424','Karimi','Ali', 18, 'MIL', 'IRN', 28, '20220017');
INSERT INTO Humain VALUES ('00425','Hosseini','Majid', 19, 'DEF', 'IRN', 26, '20220017');
INSERT INTO Humain VALUES ('00426','Azmoun','Sardar', 20, 'ATT', 'IRN', 27, '20220017');
INSERT INTO Humain VALUES ('00427','Noorollahi','Ahmad', 21, 'MIL', 'IRN', 29, '20220017');
INSERT INTO Humain VALUES ('00428','Abedzadeh','Amir', 22, 'GB', 'IRN', 29, '20220017');  
INSERT INTO Humain VALUES ('00429','Rezaeian','Ramin', 23, 'DEF', 'IRN', 32, '20220017');
INSERT INTO Humain VALUES ('00430','Hosseini','Hossein', 24, 'GB', 'IRN', 30, '20220017');
INSERT INTO Humain VALUES ('00431','Jalali','Abolfazl', 25, 'DEF', 'IRN', 24, '20220017');

INSERT INTO Humain VALUES ('00432','Berhalter','Gregg', null, 'ENT', 'USA', 49, '20220018');
INSERT INTO Humain VALUES ('00433','Turner','Matt', 1, 'GB', 'USA', 28, '20220018');
INSERT INTO Humain VALUES ('00434','Dest','Sergino', 2, 'DEF', 'USA', 22, '20220018'); 
INSERT INTO Humain VALUES ('00435','Zimmerman','Walker', 3, 'DEF', 'USA', 29, '20220018');
INSERT INTO Humain VALUES ('00436','Adams','Tyler', 4, 'MIL', 'USA', 23, '20220018');
INSERT INTO Humain VALUES ('00437','Robinson','Antonee', 5, 'DEF', 'USA', 25, '20220018');
INSERT INTO Humain VALUES ('00438','Musah','Yunus', 6, 'MIL', 'USA', 19, '20220018');
INSERT INTO Humain VALUES ('00439','Reyna','Gio', 7, 'ATT', 'USA', 20, '20220018');
INSERT INTO Humain VALUES ('00440','McKennie','Weston', 8, 'MIL', 'USA', 24, '20220018');
INSERT INTO Humain VALUES ('00441','Ferreira','Jesus', 9, 'ATT', 'USA', 21, '20220018');
INSERT INTO Humain VALUES ('00442','Pulisic','Christian', 10, 'ATT', 'USA', 24, '20220018');
INSERT INTO Humain VALUES ('00443','Aaronson','Brenden', 11, 'ATT', 'USA', 22, '20220018');
INSERT INTO Humain VALUES ('00444','Horvath','Ethan', 12, 'GB', 'USA', 27, '20220018');
INSERT INTO Humain VALUES ('00445','Ream','Tim', 13, 'DEF', 'USA', 35, '20220018');
INSERT INTO Humain VALUES ('00446','De La Torre','Lucas', 14, 'MIL', 'USA', 24, '20220018');
INSERT INTO Humain VALUES ('00447','Long','Aaron', 15, 'DEF', 'USA', 30, '20220018');
INSERT INTO Humain VALUES ('00448','Morris','Jordan', 16, 'ATT', 'USA', 28, '20220018');
INSERT INTO Humain VALUES ('00449','Roldan','Cristian', 17, 'MIL', 'USA', 32, '20220018');
INSERT INTO Humain VALUES ('00450','Moore','Shaquell', 18, 'DEF', 'USA', 26, '20220018');
INSERT INTO Humain VALUES ('00451','Wright','Haji', 19, 'ATT', 'USA', 24, '20220018');
INSERT INTO Humain VALUES ('00452','Carter-Vickers','Cameron', 20, 'DEF', 'USA', 24, '20220018');
INSERT INTO Humain VALUES ('00453','Weah','Timothy', 21, 'ATT', 'USA', 22, '20220018');
INSERT INTO Humain VALUES ('00454','Yedlin','DeAndre', 22, 'DEF', 'USA', 29, '20220018');  
INSERT INTO Humain VALUES ('00455','Acosta','Kellyn', 23, 'MIL', 'USA', 27, '20220018');
INSERT INTO Humain VALUES ('00456','Sargent','Joshua', 24, 'ATT', 'USA', 22, '20220018');
INSERT INTO Humain VALUES ('00457','Johnson','Sean', 25, 'GB', 'USA', 33, '20220018');
INSERT INTO Humain VALUES ('00458','Scally','Joe', 26, 'DEF', 'USA', 19, '20220018');

INSERT INTO Humain VALUES ('00459','Addo','Otto', null, 'ENT', 'GHA', 47, '20220019');
INSERT INTO Humain VALUES ('00460','Ati-Zigi','Lawrence', 1, 'GB', 'GHA', 25, '20220019');
INSERT INTO Humain VALUES ('00461','Lamptey','Tariq', 2, 'DEF', 'GHA', 22, '20220019'); 
INSERT INTO Humain VALUES ('00462','Odoi','Denis', 3, 'DEF', 'GHA', 34, '20220019');
INSERT INTO Humain VALUES ('00463','Salisu','Mohammed', 4, 'DEF', 'GHA', 23, '20220019');
INSERT INTO Humain VALUES ('00464','Partey','Thomas', 5, 'MIL', 'GHA', 29, '20220019');
INSERT INTO Humain VALUES ('00465','Owusu','Samuel', 6, 'MIL', 'GHA', 25, '20220019');
INSERT INTO Humain VALUES ('00466','Fatawu Issahaku','Abdul', 7, 'MIL', 'GHA', 18, '20220019');
INSERT INTO Humain VALUES ('00467','Kyereh','Daniel-Kofi', 8, 'MIL', 'GHA', 26, '20220019');
INSERT INTO Humain VALUES ('00468','Ayew','Jordan', 9, 'ATT', 'GHA', 31, '20220019');
INSERT INTO Humain VALUES ('00469','Ayew','Andre', 10, 'ATT', 'GHA', 32, '20220019');
INSERT INTO Humain VALUES ('00470','Bukari','Osman', 11, 'MIL', 'GHA', 23, '20220019');
INSERT INTO Humain VALUES ('00471','Danlad','Ibrahim', 12, 'GB', 'GHA', 19, '20220019');
INSERT INTO Humain VALUES ('00472','Afriyie','Daniel', 13, 'MIL', 'GHA', 21, '20220019');
INSERT INTO Humain VALUES ('00473','Mensah','Gideon', 14, 'DEF', 'GHA', 24, '20220019');
INSERT INTO Humain VALUES ('00474','Aidoo','Joseph', 15, 'DEF', 'GHA', 27, '20220019');
INSERT INTO Humain VALUES ('00475','Manaf Nurudeen','Abdul', 16, 'GB', 'GHA', 23, '20220019');
INSERT INTO Humain VALUES ('00476','Rahman','Baba', 17, 'DEF', 'GHA', 28, '20220019');
INSERT INTO Humain VALUES ('00477','Amartey','Daniel', 18, 'DEF', 'GHA', 27, '20220019');
INSERT INTO Humain VALUES ('00478','Williams','Inaki', 19, 'ATT', 'GHA', 28, '20220019');
INSERT INTO Humain VALUES ('00479','Kudus','Mohammed', 20, 'MIL', 'GHA', 22, '20220019');
INSERT INTO Humain VALUES ('00480','Abdul Samed','Salis', 21, 'MIL', 'GHA', 22, '20220019');
INSERT INTO Humain VALUES ('00481','Sulemana','Kamaldeen', 22, 'MIL', 'GHA', 20, '20220019');  
INSERT INTO Humain VALUES ('00482','Djiku','Alexander', 23, 'DEF', 'GHA', 28, '20220019');
INSERT INTO Humain VALUES ('00483','Sowah','Kamal', 24, 'MIL', 'GHA', 22, '20220019');
INSERT INTO Humain VALUES ('00484','Semenyo','Antoine', 25, 'ATT', 'GHA', 22, '20220019');
INSERT INTO Humain VALUES ('00485','Seidu','Alidu', 26, 'DEF', 'GHA', 22, '20220019');

INSERT INTO Humain VALUES ('00486','Martinez','Roberto', null, 'ENT', 'ESP', 49, '20220020');
INSERT INTO Humain VALUES ('00487','Courtois','Thibaut', 1, 'GB', 'BEL', 30, '20220020');
INSERT INTO Humain VALUES ('00488','Alderweireld','Toby', 2, 'DEF', 'BEL', 33, '20220020'); 
INSERT INTO Humain VALUES ('00489','Theate','Arthur', 3, 'DEF', 'BEL', 22, '20220020');
INSERT INTO Humain VALUES ('00490','Faes','Wout', 4, 'DEF', 'BEL', 24, '20220020');
INSERT INTO Humain VALUES ('00491','Vertonghen','Jan', 5, 'DEF', 'BEL', 35, '20220020');
INSERT INTO Humain VALUES ('00492','Witsel','Axel', 6, 'MIL', 'BEL', 33, '20220020');
INSERT INTO Humain VALUES ('00493','De Bruyne','Kevin', 7, 'MIL', 'BEL', 31, '20220020');
INSERT INTO Humain VALUES ('00494','Tielemans','Youri', 8, 'MIL', 'BEL', 25, '20220020');
INSERT INTO Humain VALUES ('00495','Lukaku','Romelu', 9, 'ATT', 'BEL', 29, '20220020');
INSERT INTO Humain VALUES ('00496','Hazard','Eden', 10, 'ATT', 'BEL', 31, '20220020');
INSERT INTO Humain VALUES ('00497','Carrasco','Yannick', 11, 'ATT', 'BEL', 29, '20220020');
INSERT INTO Humain VALUES ('00498','Mignolet','Simon', 12, 'GB', 'BEL', 34, '20220020');
INSERT INTO Humain VALUES ('00499','Casteels','Koen', 13, 'GB', 'BEL', 30, '20220020');
INSERT INTO Humain VALUES ('00500','Mertens','Dries', 14, 'ATT', 'BEL', 35, '20220020');
INSERT INTO Humain VALUES ('00501','Meunier','Thomas', 15, 'MIL', 'BEL', 31, '20220020');
INSERT INTO Humain VALUES ('00502','Hazard','Thorgan', 16, 'MIL', 'BEL', 29, '20220020');
INSERT INTO Humain VALUES ('00503','Trossard','Leandro', 17, 'ATT', 'BEL', 27, '20220020');
INSERT INTO Humain VALUES ('00504','Onana','Amadou', 18, 'MIL', 'BEL', 21, '20220020');
INSERT INTO Humain VALUES ('00505','Dendoncker','Leander', 19, 'DEF', 'BEL', 27, '20220020');
INSERT INTO Humain VALUES ('00506','Vanaken','Hans', 20, 'MIL', 'BEL', 30, '20220020');
INSERT INTO Humain VALUES ('00507','Castagne','Timothy', 21, 'MIL', 'BEL', 26, '20220020');
INSERT INTO Humain VALUES ('00508','De Ketelaere','Charles', 22, 'ATT', 'BEL', 21, '20220020');  
INSERT INTO Humain VALUES ('00509','Batshuayi','Michy', 23, 'ATT', 'BEL', 29, '20220020');
INSERT INTO Humain VALUES ('00510','Openda','Lois', 24, 'ATT', 'BEL', 22, '20220020');
INSERT INTO Humain VALUES ('00511','Doku','Jérémy', 25, 'ATT', 'BEL', 20, '20220020');
INSERT INTO Humain VALUES ('00512','Debast','Zeno', 26, 'DEF', 'BEL', 19, '20220020');

INSERT INTO Humain VALUES ('00513','Renard','Hervé', null, 'ENT', 'FRA', 54, '20220021');
INSERT INTO Humain VALUES ('00514','Al Rubaie','Mohammed', 1, 'GB', 'KSA', 25, '20220021');
INSERT INTO Humain VALUES ('00515','Al-Ghanam','Sultan', 2, 'DEF', 'KSA', 28, '20220021'); 
INSERT INTO Humain VALUES ('00516','Madu','Abdullah', 3, 'DEF', 'KSA', 29, '20220021');
INSERT INTO Humain VALUES ('00517','Al-Amri','Abdulelah', 4, 'DEF', 'KSA', 25, '20220021');
INSERT INTO Humain VALUES ('00518','Al-Bulaihi','Ali', 5, 'DEF', 'KSA', 32, '20220021');
INSERT INTO Humain VALUES ('00519','Al-Breik','Mohammed', 6, 'DEF', 'KSA', 30, '20220021');
INSERT INTO Humain VALUES ('00520','Al-Faraj','Salman', 7, 'MIL', 'KSA', 33, '20220021');
INSERT INTO Humain VALUES ('00521','Al-Malki','Abdulellah', 8, 'MIL', 'KSA', 28, '20220021');
INSERT INTO Humain VALUES ('00522','Al-Buraikan','Firas', 9, 'ATT', 'KSA', 22, '20220021');
INSERT INTO Humain VALUES ('00523','al-Dossari','SaleM', 10, 'ATT', 'KSA', 31, '20220021');
INSERT INTO Humain VALUES ('00524','Al-Shehri','Saleh', 11, 'ATT', 'KSA', 29, '20220021');
INSERT INTO Humain VALUES ('00525','Abdulhamid','Saud', 12, 'DEF', 'KSA', 23, '20220021');
INSERT INTO Humain VALUES ('00526','al-Shahrani','Yasser', 13, 'DEF', 'KSA', 30, '20220021');
INSERT INTO Humain VALUES ('00527','Otayf','Abdullah', 14, 'MIL', 'KSA', 30, '20220021');
INSERT INTO Humain VALUES ('00528','Al-Hassan','Ali', 15, 'MIL', 'KSA', 25, '20220021');
INSERT INTO Humain VALUES ('00529','Al-Najei','Sami', 16, 'MIL', 'KSA', 25, '20220021');
INSERT INTO Humain VALUES ('00530','Al-Tambakti','Hassan', 17, 'DEF', 'KSA', 23, '20220021');
INSERT INTO Humain VALUES ('00531','al-Abed','Nawaf', 18, 'MIL', 'KSA', 32, '20220021');
INSERT INTO Humain VALUES ('00532','Bahebri','Hattan', 19, 'ATT', 'KSA', 30, '20220021');
INSERT INTO Humain VALUES ('00533','Al-Aboud','Abdulrahman', 20, 'ATT', 'KSA', 27, '20220021');
INSERT INTO Humain VALUES ('00534','Al-Owais','MohammeD', 21, 'GB', 'KSA', 31, '20220021');
INSERT INTO Humain VALUES ('00535','Al-Aqidi','Nawaf', 22, 'GB', 'KSA', 22, '20220021');  
INSERT INTO Humain VALUES ('00536','Kanno','Mohamed', 23, 'MIL', 'KSA', 28, '20220021');
INSERT INTO Humain VALUES ('00537','Al-Dawsari','Nasser', 24, 'MIL', 'KSA', 22, '20220021');
INSERT INTO Humain VALUES ('00538','Asiri','Haitham', 25, 'ATT', 'KSA', 21, '20220021');
INSERT INTO Humain VALUES ('00539','Sharahili','Riyadh', 26, 'MIL', 'KSA', 29, '20220021');

INSERT INTO Humain VALUES ('00540','Page','Rob', null, 'ENT', 'WAL', 48, '20220022');
INSERT INTO Humain VALUES ('00541','Hennessey','Wayne', 1, 'GB', 'WAL', 35, '20220022');
INSERT INTO Humain VALUES ('00542','Gunter','Chris', 2, 'DEF', 'WAL', 33, '20220022'); 
INSERT INTO Humain VALUES ('00543','Williams','Neco', 3, 'DEF', 'WAL', 21, '20220022');
INSERT INTO Humain VALUES ('00544','Davies','Ben', 4, 'DEF', 'WAL', 29, '20220022');
INSERT INTO Humain VALUES ('00545','Mepham','Chris', 5, 'DEF', 'WAL', 25, '20220022');
INSERT INTO Humain VALUES ('00546','Rodon','Joe', 6, 'DEF', 'WAL', 25, '20220022');
INSERT INTO Humain VALUES ('00547','Allen','Joe', 7, 'MIL', 'WAL', 32, '20220022');
INSERT INTO Humain VALUES ('00548','Wilson','Harry', 8, 'MIL', 'WAL', 25, '20220022');
INSERT INTO Humain VALUES ('00549','Johnson','Brennan', 9, 'ATT', 'WAL', 21, '20220022');
INSERT INTO Humain VALUES ('00550','Ramsey','Aaron', 10, 'MIL', 'WAL', 31, '20220022');
INSERT INTO Humain VALUES ('00551','Bale','Gareth', 11, 'ATT', 'WAL', 33, '20220022');
INSERT INTO Humain VALUES ('00552','Ward','Danny', 12, 'GB', 'WAL', 29, '20220022');
INSERT INTO Humain VALUES ('00553','Moore','Kieffer', 13, 'ATT', 'WAL', 30, '20220022');
INSERT INTO Humain VALUES ('00554','Roberts','Connor', 14, 'DEF', 'WAL', 27, '20220022');
INSERT INTO Humain VALUES ('00555','Ampadu','Ethan', 15, 'DEF', 'WAL', 22, '20220022');
INSERT INTO Humain VALUES ('00556','Morrell','Joe', 16, 'MIL', 'WAL', 25, '20220022');
INSERT INTO Humain VALUES ('00557','Lockyer','Tom', 17, 'DEF', 'WAL', 27, '20220022');
INSERT INTO Humain VALUES ('00558','Williams','Jonathan', 18, 'MIL', 'WAL', 29, '20220022');
INSERT INTO Humain VALUES ('00559','Harris','Mark', 19, 'ATT', 'WAL', 23, '20220022');
INSERT INTO Humain VALUES ('00560','James','Daniel', 20, 'ATT', 'WAL', 25, '20220022');
INSERT INTO Humain VALUES ('00561','Davies','Adam', 21, 'GB', 'WAL', 30, '20220022');
INSERT INTO Humain VALUES ('00562','Thomas','Sorba', 22, 'MIL', 'WAL', 23, '20220022');  
INSERT INTO Humain VALUES ('00563','Levitt','Dylan', 23, 'MIL', 'WAL', 22, '20220022');
INSERT INTO Humain VALUES ('00564','Cabango','Ben', 24, 'DEF', 'WAL', 22, '20220022');
INSERT INTO Humain VALUES ('00565','Colwill','Rubin', 25, 'DEF', 'WAL', 20, '20220022');
INSERT INTO Humain VALUES ('00566','Smith','Matthew', 26, 'MIL', 'WAL', 22, '20220022');

INSERT INTO Humain VALUES ('00567','Stojkovic','Dragan', null, 'ENT', 'SRB', 57, '20220023');
INSERT INTO Humain VALUES ('00568','Dmitrovic','Marko', 1, 'GB', 'SRB', 30, '20220023');
INSERT INTO Humain VALUES ('00569','Pavlovic','Strahinja', 2, 'DEF', 'SRB', 21, '20220023'); 
INSERT INTO Humain VALUES ('00570','Erakovic','Strahinja', 3, 'DEF', 'SRB', 21, '20220023');
INSERT INTO Humain VALUES ('00571','Milenkovic','Nikola', 4, 'DEF', 'SRB', 25, '20220023');
INSERT INTO Humain VALUES ('00572','Veljkovic','Milos', 5, 'DEF', 'SRB', 27, '20220023');
INSERT INTO Humain VALUES ('00573','Maksimovic','Nemanja', 6, 'MIL', 'SRB', 27, '20220023');
INSERT INTO Humain VALUES ('00574','Radonjic','Nemanja', 7, 'ATT', 'SRB', 26, '20220023');
INSERT INTO Humain VALUES ('00575','Gudelj','Nemanja', 8, 'MIL', 'SRB', 31, '20220023');
INSERT INTO Humain VALUES ('00576','Mitrovic','Aleksandar', 9, 'ATT', 'SRB', 28, '20220023');
INSERT INTO Humain VALUES ('00577','Tadic','Dusan', 10, 'ATT', 'SRB', 34, '20220023');
INSERT INTO Humain VALUES ('00578','Jovic','Luka', 11, 'ATT', 'SRB', 24, '20220023');
INSERT INTO Humain VALUES ('00579','Rajkovic','Predrag', 12, 'GB', 'SRB', 27, '20220023');
INSERT INTO Humain VALUES ('00580','Mitrovic','Stefan', 13, 'DEF', 'SRB', 32, '20220023');
INSERT INTO Humain VALUES ('00581','Zivkovic','Andrija', 14, 'MIL', 'SRB', 26, '20220023');
INSERT INTO Humain VALUES ('00582','Babic','Srdjan', 15, 'DEF', 'SRB', 26, '20220023');
INSERT INTO Humain VALUES ('00583','Lukic','Sasa', 16, 'MIL', 'SRB', 26, '20220023');
INSERT INTO Humain VALUES ('00584','Kostic','Filip', 17, 'MIL', 'SRB', 30, '20220023');
INSERT INTO Humain VALUES ('00585','Vlahovic','Dusan', 18, 'ATT', 'SRB', 22, '20220023');
INSERT INTO Humain VALUES ('00586','Racic','Uros', 19, 'MIL', 'SRB', 24, '20220023');
INSERT INTO Humain VALUES ('00587','Milinkovic-Savic','Sergej', 20, 'MIL', 'SRB', 27, '20220023');
INSERT INTO Humain VALUES ('00588','Duricic','Filip', 21, 'ATT', 'SRB', 30, '20220023');
INSERT INTO Humain VALUES ('00589','Lazovic','Darko', 22, 'MIL', 'SRB', 32, '20220023');  
INSERT INTO Humain VALUES ('00590','Milinkovic-Savic','Vanja', 23, 'GB', 'SRB', 25, '20220023');
INSERT INTO Humain VALUES ('00591','Ilic','Ivan', 24, 'MIL', 'SRB', 21, '20220023');
INSERT INTO Humain VALUES ('00592','Mladenovic','Filip', 25, 'DEF', 'SRB', 31, '20220023');
INSERT INTO Humain VALUES ('00593','Grujic','Marko', 26, 'MIL', 'SRB', 26, '20220023');

INSERT INTO Humain VALUES ('00594','Scalon','Lionel', null, 'ENT', 'ARG', 44, '20220024');
INSERT INTO Humain VALUES ('00595','Armani','Franco', 1, 'GB', 'ARG', 36, '20220024');
INSERT INTO Humain VALUES ('00596','Foyth','Juan', 2, 'DEF', 'ARG', 24, '20220024'); 
INSERT INTO Humain VALUES ('00597','Tagliafico','Nicolas', 3, 'DEF', 'ARG', 30, '20220024');
INSERT INTO Humain VALUES ('00598','Montiel','Gonzalo', 4, 'DEF', 'ARG', 25, '20220024');
INSERT INTO Humain VALUES ('00599','Paredes','Leandro', 5, 'MIL', 'ARG', 28, '20220024');
INSERT INTO Humain VALUES ('00600','Pezzella','German', 6, 'DEF', 'ARG', 31, '20220024');
INSERT INTO Humain VALUES ('00601','De Paul','Rodrigo', 7, 'MIL', 'ARG', 28, '20220024');
INSERT INTO Humain VALUES ('00602','Acuña','Marcos', 8, 'DEF', 'ARG', 31, '20220024');
INSERT INTO Humain VALUES ('00603','Alvarez','Julian', 9, 'ATT', 'ARG', 22, '20220024');
INSERT INTO Humain VALUES ('00604','Messi','Lionel', 10, 'ATT', 'ARG', 35, '20220024');
INSERT INTO Humain VALUES ('00605','Di Maria','Angel', 11, 'ATT', 'ARG', 34, '20220024');
INSERT INTO Humain VALUES ('00606','Rulli','Geronimo', 12, 'GB', 'ARG', 30, '20220024');
INSERT INTO Humain VALUES ('00607','Romero','Cristian', 13, 'DEF', 'ARG', 24, '20220024');
INSERT INTO Humain VALUES ('00608','Palacios','Exequiel', 14, 'MIL', 'ARG', 24, '20220024');
INSERT INTO Humain VALUES ('00609','Correa','Angel', 15, 'ATT', 'ARG', 27, '20220024');
INSERT INTO Humain VALUES ('00610','Almada','Thiago', 16, 'MIL', 'ARG', 21, '20220024');
INSERT INTO Humain VALUES ('00611','Gomez','Papu', 17, 'MIL', 'ARG', 34, '20220024');
INSERT INTO Humain VALUES ('00612','Rodriguez','Guido', 18, 'MIL', 'ARG', 28, '20220024');
INSERT INTO Humain VALUES ('00613','Otamendi','Nicolas', 19, 'DEF', 'ARG', 34, '20220024');
INSERT INTO Humain VALUES ('00614','Mac Allister','Alexis', 20, 'MIL', 'ARG', 23, '20220024');
INSERT INTO Humain VALUES ('00615','Dybala','Paulo', 21, 'ATT', 'ARG', 29, '20220024');
INSERT INTO Humain VALUES ('00616','Martinez','Lautaro', 22, 'ATT', 'ARG', 25, '20220024');  
INSERT INTO Humain VALUES ('00617','Martinez','Emiliano', 23, 'GB', 'ARG', 30, '20220024');
INSERT INTO Humain VALUES ('00618','Fernandez','Enzo', 24, 'MIL', 'ARG', 21, '20220024');
INSERT INTO Humain VALUES ('00619','Martinez','Lisandro', 25, 'DEF', 'ARG', 24, '20220024');
INSERT INTO Humain VALUES ('00620','Molina','Nahuel', 26, 'DEF', 'ARG', 24, '20220024');

INSERT INTO Humain VALUES ('00621','Herdman','John', null, 'ENT', 'ENG', 47, '20220025');
INSERT INTO Humain VALUES ('00622','St. Clair','Dayne', 1, 'GB', 'CAN', 25, '20220025');
INSERT INTO Humain VALUES ('00623','Johnston','Alistair', 2, 'DEF', 'CAN', 24, '20220025'); 
INSERT INTO Humain VALUES ('00624','Adekugbe','Sam', 3, 'DEF', 'CAN', 27, '20220025');
INSERT INTO Humain VALUES ('00625','Miller','Kamal', 4, 'DEF', 'CAN', 25, '20220025');
INSERT INTO Humain VALUES ('00626','Vitoria','Steven', 5, 'DEF', 'CAN', 35, '20220025');
INSERT INTO Humain VALUES ('00627','Piette','Samuel', 6, 'MIL', 'CAN', 28, '20220025');
INSERT INTO Humain VALUES ('00628','Eustáquio','Stephen', 7, 'MIL', 'CAN', 25, '20220025');
INSERT INTO Humain VALUES ('00629','Fraser','Liam', 8, 'MIL', 'CAN', 24, '20220025');
INSERT INTO Humain VALUES ('00630','Cavallini','Lucas', 9, 'ATT', 'CAN', 29, '20220025');
INSERT INTO Humain VALUES ('00631','Hoilett','Junior', 10, 'ATT', 'CAN', 32, '20220025');
INSERT INTO Humain VALUES ('00632','Buchanan','Tajon', 11, 'ATT', 'CAN', 23, '20220025');
INSERT INTO Humain VALUES ('00633','Ugbo','Iké', 12, 'ATT', 'CAN', 24, '20220025');
INSERT INTO Humain VALUES ('00634','Hutchinson','Atiba', 13, 'MIL', 'CAN', 39, '20220025');
INSERT INTO Humain VALUES ('00635','Kaye','Mark-Anthony', 14, 'MIL', 'CAN', 27, '20220025');
INSERT INTO Humain VALUES ('00636','Koné','Ismaël', 15, 'MIL', 'CAN', 20, '20220025');
INSERT INTO Humain VALUES ('00637','Pantemis','James', 16, 'GB', 'CAN', 25, '20220025');
INSERT INTO Humain VALUES ('00638','Larin','Cyle', 17, 'ATT', 'CAN', 27, '20220025');
INSERT INTO Humain VALUES ('00639','Borjan','Milan', 18, 'GB', 'CAN', 35, '20220025');
INSERT INTO Humain VALUES ('00640','Davies','Alphonso', 19, 'ATT', 'CAN', 22, '20220025');
INSERT INTO Humain VALUES ('00641','David','Jonathan', 20, 'ATT', 'CAN', 22, '20220025');
INSERT INTO Humain VALUES ('00642','Osorio','Jonathan', 21, 'MIL', 'CAN', 30, '20220025');
INSERT INTO Humain VALUES ('00643','Laryea','Richie', 22, 'DEF', 'CAN', 27, '20220025');  
INSERT INTO Humain VALUES ('00644','Millar','Liam', 23, 'ATT', 'CAN', 23, '20220025');
INSERT INTO Humain VALUES ('00645','Wotherspoon','David', 24, 'MIL', 'CAN', 32, '20220025');
INSERT INTO Humain VALUES ('00646','Cornelius','Derek', 25, 'DEF', 'CAN', 24, '20220025');
INSERT INTO Humain VALUES ('00647','Waterman','Joel', 26, 'DEF', 'CAN', 26, '20220025');

INSERT INTO Humain VALUES ('00648','Bento','Paulo', null, 'ENT', 'POR', 53, '20220026');
INSERT INTO Humain VALUES ('00649','Seung-gyu','Kim', 1, 'GB', 'KOR', 32, '20220026');
INSERT INTO Humain VALUES ('00650','Jong-Gyu','Yoon', 2, 'DEF', 'KOR', 34, '20220026'); 
INSERT INTO Humain VALUES ('00651','Jin-su','Kim', 3, 'DEF', 'KOR', 30, '20220026');
INSERT INTO Humain VALUES ('00652','Min-jae','Kim', 4, 'DEF', 'KOR', 26, '20220026');
INSERT INTO Humain VALUES ('00653','Woo-young','Jung', 5, 'MIL', 'KOR', 32, '20220026');
INSERT INTO Humain VALUES ('00654','In-beom','Hwang', 6, 'MIL', 'KOR', 26, '20220026');
INSERT INTO Humain VALUES ('00655','Heung-min','Son', 7, 'MIL', 'KOR', 30, '20220026');
INSERT INTO Humain VALUES ('00656','Seung-ho','Paik', 8, 'MIL', 'KOR', 25, '20220026');
INSERT INTO Humain VALUES ('00657','Gue-sung','Cho', 9, 'ATT', 'KOR', 24, '20220026');
INSERT INTO Humain VALUES ('00658','Jae-sung','Lee', 10, 'MIL', 'KOR', 30, '20220026');
INSERT INTO Humain VALUES ('00659','Hee-chan','Hwang', 11, 'MIL', 'KOR', 26, '20220026');
INSERT INTO Humain VALUES ('00660','Bum-keun','Song', 12, 'GB', 'KOR', 25, '20220026');
INSERT INTO Humain VALUES ('00661','Jun-Ho','Son', 13, 'MIL', 'KOR', 30, '20220026');
INSERT INTO Humain VALUES ('00662','Chul','Hong', 14, 'DEF', 'KOR', 32, '20220026');
INSERT INTO Humain VALUES ('00663','Moon-Hwan','Kim', 15, 'DEF', 'KOR', 27, '20220026');
INSERT INTO Humain VALUES ('00664','Ui-jo','Hwang', 16, 'ATT', 'KOR', 30, '20220026');
INSERT INTO Humain VALUES ('00665','Sang-Ho','Na', 17, 'MIL', 'KOR', 26, '20220026');
INSERT INTO Humain VALUES ('00666','Kang-In','Lee', 18, 'MIL', 'KOR', 21, '20220026');
INSERT INTO Humain VALUES ('00667','Young-gwon','Kim', 19, 'DEF', 'KOR', 32, '20220026');
INSERT INTO Humain VALUES ('00668','Kyung-won','Kwon', 20, 'DEF', 'KOR', 30, '20220026');
INSERT INTO Humain VALUES ('00669','Hyeon-woo','Jo', 21, 'GB', 'KOR', 31, '20220026');
INSERT INTO Humain VALUES ('00670','Chang-hoon','Kwon', 22, 'MIL', 'KOR', 28, '20220026');  
INSERT INTO Humain VALUES ('00671','Tae-hwan','Kim', 23, 'DEF', 'KOR', 22, '20220026');
INSERT INTO Humain VALUES ('00672','Yu-Min','Cho', 24, 'DEF', 'KOR', 26, '20220026');
INSERT INTO Humain VALUES ('00673','Woo-Yeong','Jeong', 25, 'MIL', 'KOR', 23, '20220026');
INSERT INTO Humain VALUES ('00674','Min-kyu','Song', 26, 'MIL', 'KOR', 23, '20220026');

INSERT INTO Humain VALUES ('00675','Hjulmand','Kasper', null, 'ENT', 'DEN', 50, '20220027');
INSERT INTO Humain VALUES ('00676','Schmeichel','Kasper', 1, 'GB', 'DEN', 36, '20220027');
INSERT INTO Humain VALUES ('00677','Andersen','Joachim', 2, 'DEF', 'DEN', 26, '20220027'); 
INSERT INTO Humain VALUES ('00678','Nelsson','Victor', 3, 'DEF', 'DEN', 24, '20220027');
INSERT INTO Humain VALUES ('00679','Kjaer','Simon', 4, 'DEF', 'DEN', 33, '20220027');
INSERT INTO Humain VALUES ('00680','Mæhle','Joakim', 5, 'DEF', 'DEN', 25, '20220027');
INSERT INTO Humain VALUES ('00681','Christensen','Andreas', 6, 'DEF', 'DEN', 26, '20220027');
INSERT INTO Humain VALUES ('00682','Jensen','Mathias', 7, 'MIL', 'DEN', 26, '20220027');
INSERT INTO Humain VALUES ('00683','Delaney','Thomas', 8, 'MIL', 'DEN', 31, '20220027');
INSERT INTO Humain VALUES ('00684','Braithwaite','Martin', 9, 'ATT', 'DEN', 31, '20220027');
INSERT INTO Humain VALUES ('00685','Eriksen','Christian', 10, 'MIL', 'DEN', 30, '20220027');
INSERT INTO Humain VALUES ('00686','Skov Olsen','AndreaS', 11, 'MIL', 'DEN', 22, '20220027');
INSERT INTO Humain VALUES ('00687','Dolberg','Kasper', 12, 'ATT', 'DEN', 25, '20220027');
INSERT INTO Humain VALUES ('00688','Kristensen','Rasmus', 13, 'DEF', 'DEN', 25, '20220027');
INSERT INTO Humain VALUES ('00689','Damsgaard','Mikkel', 14, 'MIL', 'DEN', 22, '20220027');
INSERT INTO Humain VALUES ('00690','Norgaard','Christian', 15, 'MIL', 'DEN', 28, '20220027');
INSERT INTO Humain VALUES ('00691','Christensen','Oliver', 16, 'GB', 'DEN', 23, '20220027');
INSERT INTO Humain VALUES ('00692','Larsen','Jens Stryger', 17, 'DEF', 'DEN', 31, '20220027');
INSERT INTO Humain VALUES ('00693','Wass','Daniel', 18, 'DEF', 'DEN', 33, '20220027');
INSERT INTO Humain VALUES ('00694','Wind','Jonas', 19, 'ATT', 'DEN', 23, '20220027');
INSERT INTO Humain VALUES ('00695','Poulsen','Yussuf', 20, 'ATT', 'DEN', 28, '20220027');
INSERT INTO Humain VALUES ('00696','Cornelius','Andreas', 21, 'ATT', 'DEN', 29, '20220027');
INSERT INTO Humain VALUES ('00697','Rönnow','Frederik', 22, 'GB', 'DEN', 30, '20220027');  
INSERT INTO Humain VALUES ('00698','Hojbjerg','Pierre-Emile', 23, 'MIL', 'DEN', 27, '20220027');
INSERT INTO Humain VALUES ('00699','Skov','Robert', 24, 'MIL', 'DEN', 26, '20220027');
INSERT INTO Humain VALUES ('00700','Lindstrom','Jesper', 25, 'MIL', 'DEN', 22, '20220027');
INSERT INTO Humain VALUES ('00701','Bah','Alexander', 26, 'DEF', 'DEN', 24, '20220027');

INSERT INTO Humain VALUES ('00702','Regragui','Walid', null, 'ENT', 'MAR', 47, '20220028');
INSERT INTO Humain VALUES ('00703','Bono','Yassine', 1, 'GB', 'MAR', 31, '20220028');
INSERT INTO Humain VALUES ('00704','Hakimi','Achraf', 2, 'DEF', 'MAR', 24, '20220028'); 
INSERT INTO Humain VALUES ('00705','Mazraoui','Noussair', 3, 'DEF', 'MAR', 25, '20220028');
INSERT INTO Humain VALUES ('00706','Amrabat','Sofyan', 4, 'MIL', 'MAR', 26, '20220028');
INSERT INTO Humain VALUES ('00707','Aguerd','Nayef', 5, 'DEF', 'MAR', 26, '20220028');
INSERT INTO Humain VALUES ('00708','Saiss','Romain', 6, 'DEF', 'MAR', 32, '20220028');
INSERT INTO Humain VALUES ('00709','Ziyech','Hakim', 7, 'MIL', 'MAR', 29, '20220028');
INSERT INTO Humain VALUES ('00710','Ounahi','Azzedine', 8, 'MIL', 'MAR', 22, '20220028');
INSERT INTO Humain VALUES ('00711','Hamdallah','Abderrazak', 9, 'ATT', 'MAR', 31, '20220028');
INSERT INTO Humain VALUES ('00712','Zaroury','Anass', 10, 'MIL', 'MAR', 25, '20220028');
INSERT INTO Humain VALUES ('00713','Sabiri','Abdelhamid', 11, 'ATT', 'MAR', 26, '20220028');
INSERT INTO Humain VALUES ('00714','Mohamedi','Munir', 12, 'GB', 'MAR', 33, '20220028');
INSERT INTO Humain VALUES ('00715','Chair','Ilias', 13, 'MIL', 'MAR', 25, '20220028');
INSERT INTO Humain VALUES ('00716','Aboukhlal','Zakaria', 14, 'MIL', 'MAR', 22, '20220028');
INSERT INTO Humain VALUES ('00717','Amallah','Selim', 15, 'MIL', 'MAR', 26, '20220028');
INSERT INTO Humain VALUES ('00718','Ezzalzouli','Abdessamad', 16, 'ATT', 'MAR', 20, '20220028');
INSERT INTO Humain VALUES ('00719','Boufal','Sofiane', 17, 'MIL', 'MAR', 29, '20220028');
INSERT INTO Humain VALUES ('00720','El Yamiq','Jawad', 18, 'DEF', 'MAR', 30, '20220028');
INSERT INTO Humain VALUES ('00721','En-Nesyri','Youssef', 19, 'ATT', 'MAR', 25, '20220028');
INSERT INTO Humain VALUES ('00722','Dari','Achraf', 20, 'DEF', 'MAR', 23, '20220028');
INSERT INTO Humain VALUES ('00723','Cheddira','Walid', 21, 'ATT', 'MAR', 24, '20220028');
INSERT INTO Humain VALUES ('00724','Tagnaouti','Ahmed', 22, 'GB', 'MAR', 26, '20220028');  
INSERT INTO Humain VALUES ('00725','El Khannous','Bilal', 23, 'MIL', 'MAR', 18, '20220028');
INSERT INTO Humain VALUES ('00726','Benoun','BadR', 24, 'DEF', 'MAR', 29, '20220028');
INSERT INTO Humain VALUES ('00727','Attiyat Allah','Yahia', 25, 'DEF', 'MAR', 27, '20220028');
INSERT INTO Humain VALUES ('00728','Jabrane','Yahya', 26, 'MIL', 'MAR', 31, '20220028');

INSERT INTO Humain VALUES ('00729','Michniewicz','Czeslaw', null, 'ENT', 'POL', 52, '20220029');
INSERT INTO Humain VALUES ('00730','Szczesny','Wojciech', 1, 'GB', 'POL', 30, '20220029');
INSERT INTO Humain VALUES ('00731','Cash','Matthew', 2, 'DEF', 'POL', 25, '20220029'); 
INSERT INTO Humain VALUES ('00732','Jedrzejczyk','Artur', 3, 'DEF', 'POL', 35, '20220029');
INSERT INTO Humain VALUES ('00733','Wieteska','Mateusz', 4, 'DEF', 'POL', 25, '20220029');
INSERT INTO Humain VALUES ('00734','Bednarek','Jan', 5, 'DEF', 'POL', 26, '20220029');
INSERT INTO Humain VALUES ('00735','Bielik','Krystian', 6, 'MIL', 'POL', 24, '20220029');
INSERT INTO Humain VALUES ('00736','Milik','Arkadiusz', 7, 'ATT', 'POL', 28, '20220029');
INSERT INTO Humain VALUES ('00737','Szymanski','Damian', 8, 'MIL', 'POL', 27, '20220029');
INSERT INTO Humain VALUES ('00738','Lewandowski','Robert', 9, 'ATT', 'POL', 34, '20220029');
INSERT INTO Humain VALUES ('00739','Krychowiak','Grzegorz', 10, 'MIL', 'POL', 32, '20220029');
INSERT INTO Humain VALUES ('00740','Grosicki','Kamil', 11, 'MIL', 'POL', 34, '20220029');
INSERT INTO Humain VALUES ('00741','Skorupski','Lukasz', 12, 'GB', 'POL', 31, '20220029');
INSERT INTO Humain VALUES ('00742','Kaminski','Jakub', 13, 'MIL', 'POL', 20, '20220029');
INSERT INTO Humain VALUES ('00743','Kiwior','Jakub', 14, 'DEF', 'POL', 22, '20220029');
INSERT INTO Humain VALUES ('00744','Glik','Kamil', 15, 'DEF', 'POL', 34, '20220029');
INSERT INTO Humain VALUES ('00745','Swiderski','Karol', 16, 'ATT', 'POL', 25, '20220029');
INSERT INTO Humain VALUES ('00746','Zurkowski','Szymon', 17, 'MIL', 'POL', 25, '20220029');
INSERT INTO Humain VALUES ('00747','Bereszynski','Bartosz', 18, 'DEF', 'POL', 30, '20220029');
INSERT INTO Humain VALUES ('00748','Szymanski','Sebastian', 19, 'MIL', 'POL', 23, '20220029');
INSERT INTO Humain VALUES ('00749','Zielinski','Piotr', 20, 'MIL', 'POL', 28, '20220029');
INSERT INTO Humain VALUES ('00750','Zalewski','Nicola', 21, 'MIL', 'POL', 20, '20220029');
INSERT INTO Humain VALUES ('00751','Grabara','Kamil', 22, 'GB', 'POL', 23, '20220029');  
INSERT INTO Humain VALUES ('00752','Piatek','Krzysztof', 23, 'ATT', 'POL', 27, '20220029');
INSERT INTO Humain VALUES ('00753','Frankowski','Przemyslaw', 24, 'MIL', 'POL', 27, '20220029');
INSERT INTO Humain VALUES ('00754','Gumny','Robert', 25, 'DEF', 'POL', 24, '20220029');
INSERT INTO Humain VALUES ('00755','Skoras','Michal', 26, 'MIL', 'POL', 22, '20220029');

INSERT INTO Humain VALUES ('00756','Sanchez Bas','Félix', null, 'ENT', 'ESP', 46, '20220030');
INSERT INTO Humain VALUES ('00757','Al Sheeb','Saad', 1, 'GB', 'QAT', 32, '20220030');
INSERT INTO Humain VALUES ('00758','Miguel Correia','Pedro', 2, 'DEF', 'QAT', 32, '20220030'); 
INSERT INTO Humain VALUES ('00759','Hassan','Abdelkarim', 3, 'DEF', 'QAT', 29, '20220030');
INSERT INTO Humain VALUES ('00760','Waad','Mohammed', 4, 'MIL', 'QAT', 24, '20220030');
INSERT INTO Humain VALUES ('00761','Salman','Tarek', 5, 'DEF', 'QAT', 24, '20220030');
INSERT INTO Humain VALUES ('00762','Hatem','Abdulaziz', 6, 'MIL', 'QAT', 32, '20220030');
INSERT INTO Humain VALUES ('00763','Alaaeldin','Ahmed', 7, 'ATT', 'QAT', 29, '20220030');
INSERT INTO Humain VALUES ('00764','Asadalla','Ali', 8, 'MIL', 'QAT', 29, '20220030');
INSERT INTO Humain VALUES ('00765','Muntari','Mohamed', 9, 'ATT', 'QAT', 28, '20220030');
INSERT INTO Humain VALUES ('00766','Al-Haydos','Hassan', 10, 'ATT', 'QAT', 32, '20220030');
INSERT INTO Humain VALUES ('00767','Afif','Akram', 11, 'ATT', 'QAT', 26, '20220030');
INSERT INTO Humain VALUES ('00768','Boudiaf','Karim', 12, 'MIL', 'QAT', 32, '20220030');
INSERT INTO Humain VALUES ('00769','Kheder','Musab', 13, 'DEF', 'QAT', 29, '20220030');
INSERT INTO Humain VALUES ('00770','Ahmed','Homam', 14, 'DEF', 'QAT', 23, '20220030');
INSERT INTO Humain VALUES ('00771','Al Rawi','Bassam', 15, 'DEF', 'QAT', 26, '20220030'); 
INSERT INTO Humain VALUES ('00772','Khoukhi','Boualem', 16, 'DEF', 'QAT', 32, '20220030');
INSERT INTO Humain VALUES ('00773','Mohammad','Ismaeel', 17, 'MIL', 'QAT', 32, '20220030');
INSERT INTO Humain VALUES ('00774','Muneer','Khalid', 18, 'ATT', 'QAT', 24, '20220030');
INSERT INTO Humain VALUES ('00775','Ali','Almoez', 19, 'ATT', 'QAT', 26, '20220030');
INSERT INTO Humain VALUES ('00776','Al-Hajri','Salem', 20, 'MIL', 'QAT', 26, '20220030');
INSERT INTO Humain VALUES ('00777','Hassan','Yousef', 21, 'GB', 'QAT', 26, '20220030');
INSERT INTO Humain VALUES ('00778','Barsham','Meshaal', 22, 'GB', 'QAT', 24, '20220030');  
INSERT INTO Humain VALUES ('00779','Madibo','Assim', 23, 'MIL', 'QAT', 26, '20220030');
INSERT INTO Humain VALUES ('00780','Alhadhrami','Naif', 24, 'ATT', 'QAT', 21, '20220030');
INSERT INTO Humain VALUES ('00781','Gaber','Jassem', 25, 'DEF', 'QAT', 20, '20220030');
INSERT INTO Humain VALUES ('00782','Meshaal','Mostafa', 26, 'MIL', 'QAT', 21, '20220030');

INSERT INTO Humain VALUES ('00783','Cisse','Aliou', null, 'ENT', 'SEN', 47, '20220031');
INSERT INTO Humain VALUES ('00784','Dieng','Seny', 1, 'GB', 'SEN', 27, '20220031');
INSERT INTO Humain VALUES ('00785','Mendy','Formose', 2, 'DEF', 'SEN', 21, '20220031'); 
INSERT INTO Humain VALUES ('00786','Koulibaly','Kalidou', 3, 'DEF', 'SEN', 31, '20220031');
INSERT INTO Humain VALUES ('00787','Abou Cissé','Pape', 4, 'DEF', 'SEN', 24, '20220031');
INSERT INTO Humain VALUES ('00788','Gueye','Idrissa', 5, 'MIL', 'SEN', 33, '20220031');
INSERT INTO Humain VALUES ('00789','Mendy','Nampalys', 6, 'MIL', 'SEN', 30, '20220031');
INSERT INTO Humain VALUES ('00790','Jackson','Nicolas', 7, 'ATT', 'SEN', 21, '20220031');
INSERT INTO Humain VALUES ('00791','Kouyaté','Cheikhou', 8, 'MIL', 'SEN', 32, '20220031');
INSERT INTO Humain VALUES ('00792','Dia','Boulaye', 9, 'ATT', 'SEN', 26, '20220031');
INSERT INTO Humain VALUES ('00793','Ndiaye','Moussa', 10, 'MIL', 'SEN', 20, '20220031');
INSERT INTO Humain VALUES ('00794','Ciss','Pathé', 11, 'MIL', 'SEN', 28, '20220031');
INSERT INTO Humain VALUES ('00795','Ballo-Touré','Fodé', 12, 'DEF', 'SEN', 25, '20220031');
INSERT INTO Humain VALUES ('00796','Ndiaye','Iliman', 13, 'ATT', 'SEN', 22, '20220031');
INSERT INTO Humain VALUES ('00797','Jakobs','Ismail', 14, 'DEF', 'SEN', 23, '20220031');
INSERT INTO Humain VALUES ('00798','Diatta','Krepin', 15, 'MIL', 'SEN', 23, '20220031'); 
INSERT INTO Humain VALUES ('00799','Mendy','Edouard', 16, 'GB', 'SEN', 32, '20220031');
INSERT INTO Humain VALUES ('00800','Sarr','Pape', 17, 'MIL', 'SEN', 20, '20220031');
INSERT INTO Humain VALUES ('00801','Sarr','Ismaila', 18, 'ATT', 'SEN', 24, '20220031');
INSERT INTO Humain VALUES ('00802','Diedhiou','Famara', 19, 'ATT', 'SEN', 29, '20220031');
INSERT INTO Humain VALUES ('00803','Dieng','Bamba', 20, 'ATT', 'SEN', 22, '20220031');
INSERT INTO Humain VALUES ('00804','Sabaly','Youssouf', 21, 'DEF', 'SEN', 25, '20220031');
INSERT INTO Humain VALUES ('00805','Diallo','Abdou', 22, 'DEF', 'SEN', 24, '20220031');  
INSERT INTO Humain VALUES ('00806','Gomis','Alfred', 23, 'GB', 'SEN', 28, '20220031');
INSERT INTO Humain VALUES ('00807','Name','Moustapha', 24, 'MIL', 'SEN', 27, '20220031');
INSERT INTO Humain VALUES ('00808','Ndiaye','Mamadou', 25, 'DEF', 'SEN', 25, '20220031');
INSERT INTO Humain VALUES ('00809','Gueye','Pape', 26, 'MIL', 'SEN', 23, '20220031');

INSERT INTO Humain VALUES ('00810','Kadri','Jalel', null, 'ENT', 'TUN', 50, '20220032');
INSERT INTO Humain VALUES ('00811','Mathlouthi','Aymen', 1, 'GB', 'TUN', 38, '20220032');
INSERT INTO Humain VALUES ('00812','Ifa','Bilel', 2, 'DEF', 'TUN', 32, '20220032'); 
INSERT INTO Humain VALUES ('00813','Talbi','Montassar', 3, 'DEF', 'TUN', 24, '20220032');
INSERT INTO Humain VALUES ('00814','Meriah','Yassine', 4, 'DEF', 'TUN', 29, '20220032');
INSERT INTO Humain VALUES ('00815','Ghandri','Nader', 5, 'DEF', 'TUN', 27, '20220032');
INSERT INTO Humain VALUES ('00816','Bronn','Dylan', 6, 'DEF', 'TUN', 27, '20220032');
INSERT INTO Humain VALUES ('00817','Msakni','Youssef', 7, 'ATT', 'TUN', 32, '20220032');
INSERT INTO Humain VALUES ('00818','Mejbri','Hannibal', 8, 'MIL', 'TUN', 19, '20220032');
INSERT INTO Humain VALUES ('00819','Jebali','Issam', 9, 'ATT', 'TUN', 30, '20220032');
INSERT INTO Humain VALUES ('00820','Khazri','Wahbi', 10, 'ATT', 'TUN', 31, '20220032');
INSERT INTO Humain VALUES ('00821','Yassine Khenissi','Taha', 11, 'ATT', 'TUN', 21, '20220032');
INSERT INTO Humain VALUES ('00822','Maaloul','Ali', 12, 'DEF', 'TUN', 32, '20220032');
INSERT INTO Humain VALUES ('00823','Sassi','Ferjani', 13, 'MIL', 'TUN', 30, '20220032');
INSERT INTO Humain VALUES ('00824','Laïdouni','Aïssa', 14, 'MIL', 'TUN', 25, '20220032');
INSERT INTO Humain VALUES ('00825','Ben Romdhane','M. Ali', 15, 'MIL', 'TUN', 23, '20220032'); 
INSERT INTO Humain VALUES ('00826','Dahmen','Aymen', 16, 'GB', 'TUN', 25, '20220032');
INSERT INTO Humain VALUES ('00827','Skhiri','Ellyes', 17, 'MIL', 'TUN', 27, '20220032');
INSERT INTO Humain VALUES ('00828','Chaalali','Ghailene', 18, 'MIL', 'TUN', 28, '20220032');
INSERT INTO Humain VALUES ('00829','Jaziri','Seifeddine', 19, 'ATT', 'TUN', 29, '20220032');
INSERT INTO Humain VALUES ('00830','Dräger','Mohamed', 20, 'DEF', 'TUN', 26, '20220032');
INSERT INTO Humain VALUES ('00831','Kechrida','Wajdi', 21, 'DEF', 'TUN', 27, '20220032');
INSERT INTO Humain VALUES ('00832','Ben Saïd','Béchir', 22, 'GB', 'TUN', 27, '20220032');  
INSERT INTO Humain VALUES ('00833','Sliti','Naim', 23, 'ATT', 'TUN', 30, '20220032');
INSERT INTO Humain VALUES ('00834','Abdi','Ali', 24, 'DEF', 'TUN', 28, '20220032');
INSERT INTO Humain VALUES ('00835','Ben Slimane','Anis', 25, 'MIL', 'TUN', 21, '20220032');
INSERT INTO Humain VALUES ('00836','Hassen','Mouez', 26, 'GB', 'TUN', 27, '20220032');

INSERT INTO Humain VALUES ('00837','Santos','Fernando', null, 'ENT', 'POR', 68, '20220016');
INSERT INTO Humain VALUES ('00838','Patrício','Rui', 1, 'GB', 'POR', 34, '20220016');
INSERT INTO Humain VALUES ('00839','Dalot','Diogo', 2, 'DEF', 'POR', 23, '20220016'); 
INSERT INTO Humain VALUES ('00840','','Pepe', 3, 'DEF', 'POR', 39, '20220016');
INSERT INTO Humain VALUES ('00841','Dias','Ruben', 4, 'DEF', 'POR', 25, '20220016');
INSERT INTO Humain VALUES ('00842','Guerreiro','Raphaël', 5, 'DEF', 'POR', 28, '20220016');
INSERT INTO Humain VALUES ('00843','Palhinha','João', 6, 'MIL', 'POR', 27, '20220016');
INSERT INTO Humain VALUES ('00844','Ronaldo','Cristiano', 7, 'ATT', 'POR', 37, '20220016');
INSERT INTO Humain VALUES ('00845','Fernandes','Bruno', 8, 'MIL', 'POR', 28, '20220016');
INSERT INTO Humain VALUES ('00846','Silva','Andre', 9, 'ATT', 'POR', 27, '20220016');
INSERT INTO Humain VALUES ('00847','Silva','Bernardo', 10, 'MIL', 'POR', 28, '20220016');
INSERT INTO Humain VALUES ('00848','Félix','João', 11, 'ATT', 'POR', 23, '20220016');
INSERT INTO Humain VALUES ('00849','Sa','José', 12, 'GB', 'POR', 29, '20220016');
INSERT INTO Humain VALUES ('00850','Pereira','Danilo', 13, 'DEF', 'POR', 31, '20220016');
INSERT INTO Humain VALUES ('00851','Carvalho','William', 14, 'MIL', 'POR', 30, '20220016');
INSERT INTO Humain VALUES ('00852','Leao','Rafael', 15, 'ATT', 'POR', 23, '20220016');
INSERT INTO Humain VALUES ('00853','','Vitinha', 16, 'MIL', 'POR', 22, '20220016');
INSERT INTO Humain VALUES ('00854','Mário','João', 17, 'MIL', 'POR', 29, '20220016');
INSERT INTO Humain VALUES ('00855','Neves','Rúben', 18, 'MIL', 'POR', 25, '20220016');
INSERT INTO Humain VALUES ('00856','Mendes','Nuno', 19, 'DEF', 'POR', 20, '20220016');
INSERT INTO Humain VALUES ('00857','Cancelo','João', 20, 'DEF', 'POR', 28, '20220016');
INSERT INTO Humain VALUES ('00858','Horta','Ricardo', 21, 'ATT', 'POR', 28, '20220016');
INSERT INTO Humain VALUES ('00859','Costa','Diogo', 22, 'GB', 'POR', 23, '20220016');  
INSERT INTO Humain VALUES ('00860','Nunes','Matheus', 23, 'MIL', 'POR', 24, '20220016');
INSERT INTO Humain VALUES ('00861','Silva','Antonio', 24, 'DEF', 'POR', 19, '20220016');
INSERT INTO Humain VALUES ('00862','','Otavio', 25, 'MIL', 'POR', 27, '20220016');
INSERT INTO Humain VALUES ('00863','Ramos','Goncalo', 26, 'ATT', 'POR', 21, '20220016');

INSERT INTO Humain VALUES ('00864','AL JASSIM','Abdulrahman', null, 'ARB', 'QAT', null, null);
INSERT INTO Humain VALUES ('00865','BARTON','Ivan', null, 'ARB', 'SLV', null, null);
INSERT INTO Humain VALUES ('00866','BEATH','Chris', null, 'ARB', 'AUS', null, null);
INSERT INTO Humain VALUES ('00867','CLAUS','Raphael', null, 'ARB', 'BRA', null, null);
INSERT INTO Humain VALUES ('00868','CONGER','Matthew', null, 'ARB', 'NZL', null, null);
INSERT INTO Humain VALUES ('00869','ELFATH','Ismail', null, 'ARB', 'USA', null, null);
INSERT INTO Humain VALUES ('00870','ESCOBAR','Mario', null, 'ARB', 'GUA', null, null);
INSERT INTO Humain VALUES ('00871','FAGHANI','Alireza', null, 'ARB', 'IRN', null, null);
INSERT INTO Humain VALUES ('00872','FRAPPART','Stephanie', null, 'ARB', 'FRA', null, null);
INSERT INTO Humain VALUES ('00873','GASSAMA','Bakary', null, 'ARB', 'GAM', null, null);
INSERT INTO Humain VALUES ('00874','GHORBAL','Mustapha', null, 'ARB', 'ALG', null, null);
INSERT INTO Humain VALUES ('00875','GOMES','Victor', null, 'ARB', 'RSA', null, null);
INSERT INTO Humain VALUES ('00876','KOVACS','Istvan', null, 'ARB', 'ROU', null, null);
INSERT INTO Humain VALUES ('00877','MA','Ning', null, 'ARB', 'CHN', null, null);
INSERT INTO Humain VALUES ('00878','MAKKELIE','Danny', null, 'ARB', 'NED', null, null);
INSERT INTO Humain VALUES ('00879','MARCINIAK','Szymon', null, 'ARB', 'POL', null, null);
INSERT INTO Humain VALUES ('00880','MARTINEZ ','Said ', null, 'ARB', 'HON', null, null);
INSERT INTO Humain VALUES ('00881','MATEU','Antonio ', null, 'ARB', 'ESP', null, null);
INSERT INTO Humain VALUES ('00882','MATONTE CABRERA','Andres Matias', null, 'ARB', 'URU', null, null);
INSERT INTO Humain VALUES ('00883','MOHAMMED','Mohammed Abdulla', null, 'ARB', 'UAE', null, null);
INSERT INTO Humain VALUES ('00884','MUKANSANGA','Salima', null, 'ARB', 'RWA', null, null);
INSERT INTO Humain VALUES ('00885','NDIAYE','Maguette', null, 'ARB', 'SEN', null, null);
INSERT INTO Humain VALUES ('00886','OLIVER','Michael', null, 'ARB', 'ENG', null, null);
INSERT INTO Humain VALUES ('00887','ORSATO','Daniele', null, 'ARB', 'ITA', null, null);
INSERT INTO Humain VALUES ('00888','ORTEGA','Kevin', null, 'ARB', 'PER', null, null);
INSERT INTO Humain VALUES ('00889','RAMOS','Cesar', null, 'ARB', 'MEX', null, null);
INSERT INTO Humain VALUES ('00890','RAPALLINI','Fernando', null, 'ARB', 'ARG', null, null);
INSERT INTO Humain VALUES ('00891','SAMPAIO','Wilton', null, 'ARB', 'BRA', null, null);
INSERT INTO Humain VALUES ('00892','SIEBERT','Daniel', null, 'ARB', 'GER', null, null);
INSERT INTO Humain VALUES ('00893','SIKAZWE','Janny', null, 'ARB', 'ZAM', null, null);
INSERT INTO Humain VALUES ('00894','TAYLOR','Anthony', null, 'ARB', 'ENG', null, null);
INSERT INTO Humain VALUES ('00895','TELLO','Facundo', null, 'ARB', 'ARG', null, null);
INSERT INTO Humain VALUES ('00896','TURPIN','Clement ', null, 'ARB', 'FRA', null, null);
INSERT INTO Humain VALUES ('00897','VALENZUELA','Jesus', null, 'ARB', 'VEN', null, null);
INSERT INTO Humain VALUES ('00898','VINCIC','Slavko', null, 'ARB', 'SVN', null, null);
INSERT INTO Humain VALUES ('00899','YAMASHITA','Yoshimi', null, 'ARB', 'JPN', null, null);

INSERT INTO Humain VALUES ('00900','ABOLFAZLI','Mohammadreza', null, 'ARB', 'IRN', null, null);
INSERT INTO Humain VALUES ('00901','ABOUELREGAL','Mahmoud', null, 'ARB', 'EGY', null, null);
INSERT INTO Humain VALUES ('00902','AL MARRI','Taleb', null, 'ARB', 'QAT', null, null);
INSERT INTO Humain VALUES ('00903','ALHAMMADI','Mohamed', null, 'ARB', 'UAE', null, null);
INSERT INTO Humain VALUES ('00904','ALMAHRI','Hasan', null, 'ARB', 'UAE', null, null);
INSERT INTO Humain VALUES ('00905','ALMAQALEH','Saoud Ahmed', null, 'ARB', 'QAT', null, null);
INSERT INTO Humain VALUES ('00906','ARTENE','Mihai', null, 'ARB', 'ROU', null, null);
INSERT INTO Humain VALUES ('00907','ATKINS','Kyle', null, 'ARB', 'USA', null, null);
INSERT INTO Humain VALUES ('00908','BACK','Neuza', null, 'ARB', 'BRA', null, null);
INSERT INTO Humain VALUES ('00909','BEECHAM','Ashley', null, 'ARB', 'AUS', null, null);
INSERT INTO Humain VALUES ('00910','BELATTI','Juan Pablo', null, 'ARB', 'ARG', null, null);
INSERT INTO Humain VALUES ('00911','BENNETT','Simon', null, 'ARB', 'ENG', null, null);
INSERT INTO Humain VALUES ('00912','BESWICK','Gary', null, 'ARB', 'ENG', null, null);
INSERT INTO Humain VALUES ('00913','BONFA','Diego', null, 'ARB', 'ARG', null, null);
INSERT INTO Humain VALUES ('00914','BOSCHILIA','Bruno', null, 'ARB', 'BRA', null, null);
INSERT INTO Humain VALUES ('00915','BRAILOVSKY','Ezequiel', null, 'ARB', 'ARG', null, null);
INSERT INTO Humain VALUES ('00916','BURT','Stuart', null, 'ARB', 'ENG', null, null);
INSERT INTO Humain VALUES ('00917','CAMARA','Djibril', null, 'ARB', 'SEN', null, null);
INSERT INTO Humain VALUES ('00918','CAO','Yi', null, 'ARB', 'CHN', null, null);
INSERT INTO Humain VALUES ('00919','CARBONE','Ciro', null, 'ARB', 'ITA', null, null);
INSERT INTO Humain VALUES ('00920','CEBRIAN','Pau', null, 'ARB', 'ESP', null, null);
INSERT INTO Humain VALUES ('00921','CHADE','Gabriel', null, 'ARB', 'ARG', null, null);
INSERT INTO Humain VALUES ('00922','DANOS','Nicolas', null, 'ARB', 'FRA', null, null);
INSERT INTO Humain VALUES ('00923','DE VRIES','Jan', null, 'ARB', 'NED', null, null);
INSERT INTO Humain VALUES ('00924','DIAZ MEDINA','Karen', null, 'ARB', 'MEX', null, null);
INSERT INTO Humain VALUES ('00925','DIAZ','Roberto', null, 'ARB', 'ESP', null, null);
INSERT INTO Humain VALUES ('00926','DOS SANTOS','Jerson', null, 'ARB', 'ANG', null, null);
INSERT INTO Humain VALUES ('00927','ETCHIALI','Abdelhak', null, 'ARB', 'ALG', null, null);
INSERT INTO Humain VALUES ('00928','FELIZ','Raymundo Helpys', null, 'ARB', 'DOM', null, null);
INSERT INTO Humain VALUES ('00929','FIGUEIREDO','Rodrigo', null, 'ARB', 'BRA', null, null);
INSERT INTO Humain VALUES ('00930','FOLTYN','Rafael', null, 'ARB', 'GER', null, null);
INSERT INTO Humain VALUES ('00931','GIALLATINI','Alessandro', null, 'ARB', 'ITA', null, null);
INSERT INTO Humain VALUES ('00932','GOURARI','Mokrane', null, 'ARB', 'ALG', null, null);
INSERT INTO Humain VALUES ('00933','GRINGORE','Cyril', null, 'ARB', 'FRA', null, null);
INSERT INTO Humain VALUES ('00934','HERNANDEZ','Miguel', null, 'ARB', 'MEX', null, null);
INSERT INTO Humain VALUES ('00935','KLANCNIK','Tomaz', null, 'ARB', 'SVN', null, null);
INSERT INTO Humain VALUES ('00936','KOVACIC','Andraz', null, 'ARB', 'SVN', null, null);
INSERT INTO Humain VALUES ('00937','LISTKIEWICZ','Tomasz', null, 'ARB', 'POL', null, null);
INSERT INTO Humain VALUES ('00938','LOPEZ','Walter', null, 'ARB', 'HON', null, null);
INSERT INTO Humain VALUES ('00939','MAKASINI','Tevita', null, 'ARB', 'TGA', null, null);
INSERT INTO Humain VALUES ('00940','MANSOURI','Mohammadreza', null, 'ARB', 'IRN', null, null);
INSERT INTO Humain VALUES ('00941','MARENGULE','Arsenio', null, 'ARB', 'MOZ', null, null);
INSERT INTO Humain VALUES ('00942','MARINESCU','Vasile', null, 'ARB', 'ROU', null, null);
INSERT INTO Humain VALUES ('00943','MORA','Juan Carlos', null, 'ARB', 'CRC', null, null);
INSERT INTO Humain VALUES ('00944','MORAN','David', null, 'ARB', 'SLV', null, null);
INSERT INTO Humain VALUES ('00945','MORENO','Tulio', null, 'ARB', 'VEN', null, null);
INSERT INTO Humain VALUES ('00946','MORIN','Alberto', null, 'ARB', 'MEX', null, null);
INSERT INTO Humain VALUES ('00947','NESBITT','Kathryn', null, 'ARB', 'USA', null, null);
INSERT INTO Humain VALUES ('00948','NOUPUE','Elvis', null, 'ARB', 'CMR', null, null);
INSERT INTO Humain VALUES ('00949','NUNN','Adam', null, 'ARB', 'ENG', null, null);
INSERT INTO Humain VALUES ('00950','ORUE','Michael', null, 'ARB', 'PER', null, null);
INSERT INTO Humain VALUES ('00951','PARKER','Corey', null, 'ARB', 'USA', null, null);
INSERT INTO Humain VALUES ('00952','PHATSOANE','Souru', null, 'ARB', 'LES', null, null);
INSERT INTO Humain VALUES ('00953','PIRES','Bruno', null, 'ARB', 'BRA', null, null);
INSERT INTO Humain VALUES ('00954','RULE','Mark', null, 'ARB', 'NZL', null, null);
INSERT INTO Humain VALUES ('00955','SAMBA','El Hadji', null, 'ARB', 'SEN', null, null);
INSERT INTO Humain VALUES ('00956','SANCHEZ','Jesus', null, 'ARB', 'PER', null, null);
INSERT INTO Humain VALUES ('00957','SEIDEL','Jan', null, 'ARB', 'GER', null, null);
INSERT INTO Humain VALUES ('00958','SHCHETININ','Anton', null, 'ARB', 'AUS', null, null);
INSERT INTO Humain VALUES ('00959','SHI','Xiang', null, 'ARB', 'CHN', null, null);
INSERT INTO Humain VALUES ('00960','SIMON','Danilo', null, 'ARB', 'BRA', null, null);
INSERT INTO Humain VALUES ('00961','SIWELA','Zakhele', null, 'ARB', 'RSA', null, null);
INSERT INTO Humain VALUES ('00962','SOKOLNICKI','Pawel', null, 'ARB', 'POL', null, null);
INSERT INTO Humain VALUES ('00963','SOPPI','Martin', null, 'ARB', 'URU', null, null);
INSERT INTO Humain VALUES ('00964','STEEGSTRA','Hessel', null, 'ARB', 'NED', null, null);
INSERT INTO Humain VALUES ('00965','TARAN','Nicolas', null, 'ARB', 'URU', null, null);
INSERT INTO Humain VALUES ('00966','URREGO','Jorge', null, 'ARB', 'VEN', null, null);
INSERT INTO Humain VALUES ('00967','WALES','Caleb', null, 'ARB', 'TRI', null, null);
INSERT INTO Humain VALUES ('00968','ZEEGELAAR','Zachari', null, 'ARB', 'SUR', null, null);

INSERT INTO Arbitre VALUES ('001','00887','00968','00968','00968');
INSERT INTO Arbitre VALUES ('002','00891','00968','00968','00968');
INSERT INTO Arbitre VALUES ('003','00881','00968','00968','00968');
INSERT INTO Arbitre VALUES ('004','00874','00968','00968','00968');
INSERT INTO Arbitre VALUES ('005','00873','00968','00968','00968');
INSERT INTO Arbitre VALUES ('006','00896','00968','00968','00968');
INSERT INTO Arbitre VALUES ('007','00867','00968','00968','00968');
INSERT INTO Arbitre VALUES ('008','00864','00968','00968','00968');
INSERT INTO Arbitre VALUES ('009','00870','00968','00968','00968');
INSERT INTO Arbitre VALUES ('010','00897','00968','00968','00968');
INSERT INTO Arbitre VALUES ('011','00898','00968','00968','00968');
INSERT INTO Arbitre VALUES ('012','00881','00968','00968','00968');
INSERT INTO Arbitre VALUES ('013','00898','00968','00968','00968');
INSERT INTO Arbitre VALUES ('014','00866','00968','00968','00968');
INSERT INTO Arbitre VALUES ('015','00891','00968','00968','00968');
INSERT INTO Arbitre VALUES ('016','00887','00968','00968','00968');
INSERT INTO Arbitre VALUES ('017','00878','00968','00968','00968');
INSERT INTO Arbitre VALUES ('018','00886','00968','00968','00968');
INSERT INTO Arbitre VALUES ('019','00889','00968','00968','00968');
INSERT INTO Arbitre VALUES ('020','00875','00968','00968','00968');
INSERT INTO Arbitre VALUES ('021','00892','00968','00968','00968');
INSERT INTO Arbitre VALUES ('022','00879','00968','00968','00968');
INSERT INTO Arbitre VALUES ('023','00874','00968','00968','00968');
INSERT INTO Arbitre VALUES ('024','00868','00968','00968','00968');
INSERT INTO Arbitre VALUES ('025','00865','00968','00968','00968');
INSERT INTO Arbitre VALUES ('026','00883','00968','00968','00968');
INSERT INTO Arbitre VALUES ('027','00886','00968','00968','00968');
INSERT INTO Arbitre VALUES ('028','00878','00968','00968','00968');
INSERT INTO Arbitre VALUES ('029','00875','00968','00968','00968');
INSERT INTO Arbitre VALUES ('030','00872','00968','00968','00968');
INSERT INTO Arbitre VALUES ('031','00890','00968','00968','00968');
INSERT INTO Arbitre VALUES ('032','00893','00968','00968','00968');
INSERT INTO Arbitre VALUES ('033','00889','00968','00968','00968');
INSERT INTO Arbitre VALUES ('034','00882','00968','00968','00968');
INSERT INTO Arbitre VALUES ('035','00894','00968','00968','00968');
INSERT INTO Arbitre VALUES ('036','00867','00968','00968','00968');
INSERT INTO Arbitre VALUES ('037','00895','00968','00968','00968');
INSERT INTO Arbitre VALUES ('038','00871','00968','00968','00968');
INSERT INTO Arbitre VALUES ('039','00883','00968','00968','00968');
INSERT INTO Arbitre VALUES ('040','00865','00968','00968','00968');
INSERT INTO Arbitre VALUES ('041','00890','00968','00968','00968');
INSERT INTO Arbitre VALUES ('042','00869','00968','00968','00968');
INSERT INTO Arbitre VALUES ('043','00896','00968','00968','00968');
INSERT INTO Arbitre VALUES ('044','00869','00968','00968','00968');
INSERT INTO Arbitre VALUES ('045','00894','00968','00968','00968');
INSERT INTO Arbitre VALUES ('046','00871','00968','00968','00968');
INSERT INTO Arbitre VALUES ('047','00892','00968','00968','00968');
INSERT INTO Arbitre VALUES ('048','00895','00968','00968','00968');
INSERT INTO Arbitre VALUES ('049','00891','00968','00968','00968');
INSERT INTO Arbitre VALUES ('050','00879','00968','00968','00968');
INSERT INTO Arbitre VALUES ('051','00897','00968','00968','00968');
INSERT INTO Arbitre VALUES ('052','00865','00968','00968','00968');
INSERT INTO Arbitre VALUES ('053','00869','00968','00968','00968');
INSERT INTO Arbitre VALUES ('054','00896','00968','00968','00968');
INSERT INTO Arbitre VALUES ('055','00890','00968','00968','00968');
INSERT INTO Arbitre VALUES ('056','00889','00968','00968','00968');
INSERT INTO Arbitre VALUES ('057','00886','00968','00968','00968');
INSERT INTO Arbitre VALUES ('058','00881','00968','00968','00968');
INSERT INTO Arbitre VALUES ('059','00895','00968','00968','00968');
INSERT INTO Arbitre VALUES ('060','00891','00968','00968','00968');
INSERT INTO Arbitre VALUES ('061','00887','00968','00968','00968');
INSERT INTO Arbitre VALUES ('062','00889','00968','00968','00968');
INSERT INTO Arbitre VALUES ('063','00864','00968','00968','00968');
INSERT INTO Arbitre VALUES ('064','00879','00968','00968','00968');

INSERT INTO Match VALUES ('20220100','A','2022-11-20 19:00:00','001','20220030', '20220015','Groupe','Al-Bayt','0-2',null, 'Ext');
INSERT INTO Match VALUES ('20220200','A','2022-11-21 19:00:00','002','20220031', '20220009','Groupe','Al-Thumama','0-2',null, 'Ext');
INSERT INTO Match VALUES ('20220300','A','2022-11-25 16:00:00','003','20220030', '20220031','Groupe','Al-Thumama','1-3',null, 'Ext');
INSERT INTO Match VALUES ('20220400','A','2022-11-25 19:00:00','004','20220009', '20220015','Groupe','Stade international de Khalifa','1-1',null, 'Dom');
INSERT INTO Match VALUES ('20220500','A','2022-11-29 18:00:00','005','20220009', '20220030','Groupe','Al-Bayt','2-0',null, 'Ext');
INSERT INTO Match VALUES ('20220600','A','2022-11-29 18:00:00','006','20220015', '20220031','Groupe','Stade international de Khalifa','1-2',null, 'Ext');

INSERT INTO Match VALUES ('20220700','B','2022-11-21 16:00:00','007','20220003', '20220017','Groupe','Stade international de Khalifa','6-2',null, 'Dom');
INSERT INTO Match VALUES ('20220800','B','2022-11-21 22:00:00','008','20220018', '20220022','Groupe','Ahmad-ben-Ali','1-1',null, 'Nul');
INSERT INTO Match VALUES ('20220900','B','2022-11-25 13:00:00','009','20220022', '20220017','Groupe','Ahmad-ben-Ali','0-2',null, 'Ext');
INSERT INTO Match VALUES ('20221000','B','2022-11-25 22:00:00','010','20220003', '20220018','Groupe','Al-Bayt','0-0',null, 'Nul');
INSERT INTO Match VALUES ('20221100','B','2022-11-29 22:00:00','011','20220022', '20220003','Groupe','Ahmad-ben-Ali','0-3',null, 'Ext');
INSERT INTO Match VALUES ('20221200','B','2022-11-29 22:00:00','012','20220017', '20220018','Groupe','Al-Thumama','0-1',null, 'Ext');

INSERT INTO Match VALUES ('20221300','C','2022-11-22 13:00:00','013','20220024', '20220021','Groupe','Stade de Lusail','1-2',null, 'Ext');
INSERT INTO Match VALUES ('20221400','C','2022-11-22 19:00:00','014','20220007', '20220029','Groupe','Stade 974','0-0',null, 'Nul');
INSERT INTO Match VALUES ('20221500','C','2022-11-26 16:00:00','015','20220029', '20220021','Groupe','Education City','2-0',null, 'Dom');
INSERT INTO Match VALUES ('20221600','C','2022-11-26 22:00:00','016','20220024', '20220007','Groupe','Stade de Lusail','2-0',null, 'Dom');
INSERT INTO Match VALUES ('20221700','C','2022-11-30 22:00:00','017','20220029', '20220024','Groupe','Stade 974','0-2',null, 'Ext');
INSERT INTO Match VALUES ('20221800','C','2022-11-30 22:00:00','018','20220021', '20220007','Groupe','Stade de Lusail','1-2',null, 'Ext');

INSERT INTO Match VALUES ('20221900','D','2022-11-22 16:00:00','019','20220027', '20220032','Groupe','Education City','0-0',null, 'Nul');
INSERT INTO Match VALUES ('20222000','D','2022-11-22 22:00:00','020','20220001', '20220010','Groupe','Al-Janoub','4-1',null, 'Dom');
INSERT INTO Match VALUES ('20222100','D','2022-11-26 13:00:00','021','20220032', '20220010','Groupe','Al-Janoub','0-1',null, 'Ext');
INSERT INTO Match VALUES ('20222200','D','2022-11-26 19:00:00','022','20220001', '20220027','Groupe','Stade 974','2-1',null, 'Dom');
INSERT INTO Match VALUES ('20222300','D','2022-11-30 18:00:00','023','20220010', '20220027','Groupe','Al-Janoub','1-0',null, 'Dom');
INSERT INTO Match VALUES ('20222400','D','2022-11-30 18:00:00','024','20220032', '20220001','Groupe','Education City','1-0',null, 'Dom');

INSERT INTO Match VALUES ('20222500','E','2022-11-23 16:00:00','025','20220002', '20220013','Groupe','Stade international de Khalifa','1-2',null, 'Ext');
INSERT INTO Match VALUES ('20222600','E','2022-11-23 19:00:00','026','20220004', '20220012','Groupe','Al-Thumama','7-0',null, 'Dom');
INSERT INTO Match VALUES ('20222700','E','2022-11-27 13:00:00','027','20220013', '20220012','Groupe','Ahmad-ben-Ali','0-1',null, 'Ext');
INSERT INTO Match VALUES ('20222800','E','2022-11-27 22:00:00','028','20220004', '20220002','Groupe','Al-Bayt','1-1',null, 'Nul');
INSERT INTO Match VALUES ('20222900','E','2022-12-01 22:00:00','029','20220013', '20220004','Groupe','Stade international de Khalifa','2-1',null, 'Dom');
INSERT INTO Match VALUES ('20223000','E','2022-12-01 22:00:00','030','20220012', '20220002','Groupe','Al-Bayt','2-4',null, 'Ext');

INSERT INTO Match VALUES ('20223100','F','2022-11-23 13:00:00','031','20220028', '20220006','Groupe','Al-Bayt','0-0',null, 'Nul');
INSERT INTO Match VALUES ('20223200','F','2022-11-23 22:00:00','032','20220020', '20220025','Groupe','Ahmad-ben-Ali','1-0',null, 'Dom');
INSERT INTO Match VALUES ('20223300','F','2022-11-27 16:00:00','033','20220020', '20220028','Groupe','Al-Thumama','0-2',null, 'Ext');
INSERT INTO Match VALUES ('20223400','F','2022-11-27 19:00:00','034','20220006', '20220025','Groupe','Stade international de Khalifa','4-1',null, 'Dom');
INSERT INTO Match VALUES ('20223500','F','2022-12-01 18:00:00','035','20220006', '20220020','Groupe','Ahmad-ben-Ali','0-0',null, 'Nul');
INSERT INTO Match VALUES ('20223600','F','2022-12-01 18:00:00','036','20220025', '20220028','Groupe','Al-Thumama','1-2',null, 'Ext');

INSERT INTO Match VALUES ('20223700','G','2022-11-24 13:00:00','037','20220014', '20220008','Groupe','Al-Janoub','1-0',null, 'Dom');
INSERT INTO Match VALUES ('20223800','G','2022-11-24 22:00:00','038','20220005', '20220023','Groupe','Stade de Lusail','2-0',null, 'Dom');
INSERT INTO Match VALUES ('20223900','G','2022-11-28 13:00:00','039','20220008', '20220023','Groupe','Al-Janoub','3-3',null, 'Nul');
INSERT INTO Match VALUES ('20224000','G','2022-11-28 19:00:00','040','20220005', '20220014','Groupe','Stade 974','1-0',null, 'Dom');
INSERT INTO Match VALUES ('20224100','G','2022-12-02 22:00:00','041','20220023', '20220014','Groupe','Stade 974','2-3',null, 'Ext');
INSERT INTO Match VALUES ('20224200','G','2022-12-02 22:00:00','042','20220008', '20220005','Groupe','Stade de Lusail','1-0',null, 'Dom');

INSERT INTO Match VALUES ('20224300','H','2022-11-24 16:00:00','043','20220011', '20220026','Groupe','Education City','0-0',null, 'Nul');
INSERT INTO Match VALUES ('20224400','H','2022-11-24 19:00:00','044','20220016', '20220019','Groupe','Stade 974','3-2',null, 'Dom');
INSERT INTO Match VALUES ('20224500','H','2022-11-28 16:00:00','045','20220026', '20220019','Groupe','Education City','2-3',null, 'Ext');
INSERT INTO Match VALUES ('20224600','H','2022-11-28 22:00:00','046','20220016', '20220011','Groupe','Stade de Lusail','2-0',null, 'Dom');
INSERT INTO Match VALUES ('20224700','H','2022-12-02 18:00:00','047','20220019', '20220011','Groupe','Al-Janoub','0-2',null, 'Ext');
INSERT INTO Match VALUES ('20224800','H','2022-12-02 18:00:00','048','20220026', '20220016','Groupe','Education City','2-1',null, 'Dom');

INSERT INTO Match VALUES ('20224900',null,'2022-12-03 18:00:00','049','20220009', '20220018','8th','Stade international de Khalifa','3-1',null, 'Dom');
INSERT INTO Match VALUES ('20225000',null,'2022-12-03 22:00:00','050','20220024', '20220010','8th','Ahmad-ben-Ali','2-1',null, 'Dom');
INSERT INTO Match VALUES ('20225100',null,'2022-12-04 18:00:00','051','20220001', '20220029','8th','Al-Thumama','3-1',null, 'Dom');
INSERT INTO Match VALUES ('20225200',null,'2022-12-04 22:00:00','052','20220003', '20220031','8th','Al-Bayt','3-0',null, 'Dom');
INSERT INTO Match VALUES ('20225300',null,'2022-12-05 18:00:00','053','20220013', '20220006','8th','Al-Janoub','1-1','1-3', 'Nul');
INSERT INTO Match VALUES ('20225400',null,'2022-12-05 22:00:00','054','20220005', '20220026','8th','Stade 974','4-1',null, 'Dom');
INSERT INTO Match VALUES ('20225500',null,'2022-12-06 18:00:00','055','20220028', '20220004','8th','Education City','0-0','3-0', 'Nul');
INSERT INTO Match VALUES ('20225600',null,'2022-12-06 22:00:00','056','20220016', '20220014','8th','Stade de Lusail','6-1',null, 'Dom');

INSERT INTO Match VALUES ('20225700',null,'2022-12-09 18:00:00','057','20220006', '20220005','4th','Education City','1-1','4-2', 'Nul');
INSERT INTO Match VALUES ('20225800',null,'2022-12-09 22:00:00','058','20220009', '20220024','4th','Stade de Lusail','2-2','3-4', 'Nul');
INSERT INTO Match VALUES ('20225900',null,'2022-12-10 18:00:00','059','20220028', '20220016','4th','Al-Thumama','1-0',null, 'Dom');
INSERT INTO Match VALUES ('20226000',null,'2022-12-10 22:00:00','060','20220003', '20220001','4th','Al-Bayt','1-2',null, 'Ext');

INSERT INTO Match VALUES ('20226100',null,'2022-12-13 22:00:00','061','20220024', '20220006','2th','Stade de Lusail','3-0',null, 'Dom');
INSERT INTO Match VALUES ('20226200',null,'2022-12-14 22:00:00','062','20220001', '20220028','2th','Al-Bayt','2-0',null, 'Dom');

INSERT INTO Match VALUES ('20226300',null,'2022-12-17 18:00:00','063','20220006', '20220028','Petite Finale','Stade international de Khalifa','2-1',null, 'Dom');
INSERT INTO Match VALUES ('20226400',null,'2022-12-18 18:00:00','064','20220024', '20220001','Finale','Al-Bayt','3-3','4-2', 'Nul');

INSERT INTO But VALUES ('20220100','20220015','00392',null,'PENO',16);
INSERT INTO But VALUES ('20220100','20220015','00392','00396','BUT',31);

INSERT INTO But VALUES ('20220200','20220009','00225','00238','BUT',84);
INSERT INTO But VALUES ('20220200','20220009','00231',null,'BUT',99);

INSERT INTO But VALUES ('20220300','20220030','00765','00773','BUT',78);
INSERT INTO But VALUES ('20220300','20220031','00792',null,'BUT',41);
INSERT INTO But VALUES ('20220300','20220031','00802','00797','BUT',48);
INSERT INTO But VALUES ('20220300','20220031','00803','00796','BUT',84);

INSERT INTO But VALUES ('20220400','20220009','00225','00231','BUT',06);
INSERT INTO But VALUES ('20220400','20220015','00392',null,'BUT',49);

INSERT INTO But VALUES ('20220500','20220009','00225','00231','BUT',26);
INSERT INTO But VALUES ('20220500','20220009','00238',null,'BUT',49);

INSERT INTO But VALUES ('20220600','20220015','00402','00381','BUT',67);
INSERT INTO But VALUES ('20220600','20220031','00801',null,'PENO',44);
INSERT INTO But VALUES ('20220600','20220031','00786',null,'BUT',70);

INSERT INTO But VALUES ('20220700','20220003','00077','00058','BUT',35);
INSERT INTO But VALUES ('20220700','20220003','00072','00061','BUT',43);
INSERT INTO But VALUES ('20220700','20220003','00065','00064','BUT',46);
INSERT INTO But VALUES ('20220700','20220003','00072','00065','BUT',62);
INSERT INTO But VALUES ('20220700','20220003','00066','00064','BUT',71);
INSERT INTO But VALUES ('20220700','20220003','00062','00079','BUT',90);
INSERT INTO But VALUES ('20220700','20220017','00415','00423','BUT',65);
INSERT INTO But VALUES ('20220700','20220017','00415',null,'PENO',91);

INSERT INTO But VALUES ('20220800','20220018','00442','00423','BUT',36);
INSERT INTO But VALUES ('20220800','20220022','00551',null,'PENO',82);

INSERT INTO But VALUES ('20220900','20220017','00421',null,'BUT',98);
INSERT INTO But VALUES ('20220900','20220017','00551','00429','BUT',101);

INSERT INTO But VALUES ('20221100','20220003','00066',null,'BUT',50);
INSERT INTO But VALUES ('20221100','20220003','00075','00064','BUT',51);
INSERT INTO But VALUES ('20221100','20220003','00066','00069','BUT',68);

INSERT INTO But VALUES ('20221200','20220018','00442','00434','BUT',38);

INSERT INTO But VALUES ('20221300','20220024','00604',null,'PENO',10);
INSERT INTO But VALUES ('20221300','20220021','00524','00522','BUT',48);
INSERT INTO But VALUES ('20221300','20220021','00523',null,'BUT',53);

INSERT INTO But VALUES ('20221500','20220029','00749','00738','BUT',39);
INSERT INTO But VALUES ('20221500','20220029','00738',null,'BUT',82);

INSERT INTO But VALUES ('20221600','20220024','00604','00605','BUT',68);
INSERT INTO But VALUES ('20221600','20220024','00618','00604','BUT',87);

INSERT INTO But VALUES ('20221700','20220024','00614','00620','BUT',46);
INSERT INTO But VALUES ('20221700','20220024','00603','00618','BUT',67);

INSERT INTO But VALUES ('20221800','20220021','00523','00532','BUT',95);
INSERT INTO But VALUES ('20221800','20220007','00183','00166','BUT',47);
INSERT INTO But VALUES ('20221800','20220007','00187',null,'BUT',52);

INSERT INTO But VALUES ('20222000','20220001','00015','00023','BUT',27);
INSERT INTO But VALUES ('20222000','20220001','00187','00015','BUT',32);
INSERT INTO But VALUES ('20222000','20220001','00011','00012','BUT',68);
INSERT INTO But VALUES ('20222000','20220001','00010','00011','BUT',71);
INSERT INTO But VALUES ('20222000','20220010','00267','00251','BUT',09);

INSERT INTO But VALUES ('20222100','20220010','00259',null,'BUT',23);

INSERT INTO But VALUES ('20222200','20220001','00011','00023','BUT',61);
INSERT INTO But VALUES ('20222200','20220001','00011','00008','BUT',86);
INSERT INTO But VALUES ('20222200','20220027','00681','00677','BUT',68);

INSERT INTO But VALUES ('20222300','20220010','00251','00258','BUT',60);

INSERT INTO But VALUES ('20222400','20220032','00820','00824','BUT',58);

INSERT INTO But VALUES ('20222500','20220002','00049',null,'PENO',33);
INSERT INTO But VALUES ('20222500','20220013','00333',null,'BUT',75);
INSERT INTO But VALUES ('20222500','20220013','00343','00329','BUT',83);

INSERT INTO But VALUES ('20222600','20220004','00103','00091','BUT',11);
INSERT INTO But VALUES ('20222600','20220004','00092','00100','BUT',21);
INSERT INTO But VALUES ('20222600','20220004','00093',null,'PENO',31);
INSERT INTO But VALUES ('20222600','20220004','00093',null,'BUT',54);
INSERT INTO But VALUES ('20222600','20220004','00091','00089','BUT',74);
INSERT INTO But VALUES ('20222600','20220004','00101',null,'BUT',90);
INSERT INTO But VALUES ('20222600','20220004','00089','00103','BUT',92);

INSERT INTO But VALUES ('20222700','20220012','00305','00315','BUT',12);

INSERT INTO But VALUES ('20222800','20220004','00089','00100','BUT',61);
INSERT INTO But VALUES ('20222800','20220002','00037','00042','BUT',83);

INSERT INTO But VALUES ('20222900','20220013','00333','00339','BUT',48);
INSERT INTO But VALUES ('20222900','20220013','00342','00334','BUT',51);
INSERT INTO But VALUES ('20222900','20220004','00089','00084','BUT',11);

INSERT INTO But VALUES ('20223000','20220012','00315',null,'BUT',58);
INSERT INTO But VALUES ('20223000','20220012','00301',null,'BUT',70);
INSERT INTO But VALUES ('20223000','20220002','00038','00031','BUT',10);
INSERT INTO But VALUES ('20223000','20220002','00035','00037','BUT',73);
INSERT INTO But VALUES ('20223000','20220002','00035','00038','BUT',85);
INSERT INTO But VALUES ('20223000','20220002','00037','00047','BUT',89);

INSERT INTO But VALUES ('20223200','20220020','00509','00488','BUT',44);

INSERT INTO But VALUES ('20223300','20220028','00708','00713','BUT',73);
INSERT INTO But VALUES ('20223300','20220028','00716','00709','BUT',92);

INSERT INTO But VALUES ('20223400','20220006','00145','00140','BUT',36);
INSERT INTO But VALUES ('20223400','20220006','00150','00158','BUT',44);
INSERT INTO But VALUES ('20223400','20220006','00145','00140','BUT',70);
INSERT INTO But VALUES ('20223400','20220006','00143','00154','BUT',94);
INSERT INTO But VALUES ('20223400','20220025','00640','00632','BUT',02);

INSERT INTO But VALUES ('20223600','20220025','00707',null,'CSC',40);
INSERT INTO But VALUES ('20223600','20220028','00709',null,'BUT',04);
INSERT INTO But VALUES ('20223600','20220028','00721','00704','BUT',23);

INSERT INTO But VALUES ('20223700','20220014','00359','00375','BUT',48);

INSERT INTO But VALUES ('20223800','20220005','00118',null,'BUT',62);
INSERT INTO But VALUES ('20223800','20220005','00118','00129','BUT',73);

INSERT INTO But VALUES ('20223900','20220008','00211',null,'BUT',29);
INSERT INTO But VALUES ('20223900','20220008','00200','00211','BUT',63);
INSERT INTO But VALUES ('20223900','20220008','00203','00200','BUT',66);
INSERT INTO But VALUES ('20223900','20220023','00569','00577','BUT',46);
INSERT INTO But VALUES ('20223900','20220023','00587','00581','BUT',48);
INSERT INTO But VALUES ('20223900','20220023','00576','00581','BUT',53);

INSERT INTO But VALUES ('20224000','20220005','00114','00130','BUT',83);

INSERT INTO But VALUES ('20224100','20220023','00576','00577','BUT',26);
INSERT INTO But VALUES ('20224100','20220023','00585',null,'BUT',35);
INSERT INTO But VALUES ('20224100','20220014','00375','00367','BUT',20);
INSERT INTO But VALUES ('20224100','20220014','00359','00355','BUT',44);
INSERT INTO But VALUES ('20224100','20220014','00360','00369','BUT',48);

INSERT INTO But VALUES ('20224200','20220008','00200','00192','BUT',92);

INSERT INTO But VALUES ('20224400','20220016','00844',null,'PENO',65);
INSERT INTO But VALUES ('20224400','20220016','00848','00845','BUT',78);
INSERT INTO But VALUES ('20224400','20220016','00852','00845','BUT',80);
INSERT INTO But VALUES ('20224400','20220019','00469',null,'BUT',73);
INSERT INTO But VALUES ('20224400','20220019','00470',null,'BUT',89);

INSERT INTO But VALUES ('20224500','20220026','00657','00666','PENO',58);
INSERT INTO But VALUES ('20224500','20220026','00657','00651','BUT',61);
INSERT INTO But VALUES ('20224500','20220019','00463',null,'BUT',24);
INSERT INTO But VALUES ('20224500','20220019','00479','00468','BUT',34);
INSERT INTO But VALUES ('20224500','20220019','00479','00473','BUT',68);

INSERT INTO But VALUES ('20224600','20220016','00845','00842','BUT',54);
INSERT INTO But VALUES ('20224600','20220016','00845',null,'PENO',93);

INSERT INTO But VALUES ('20224700','20220011','00281',null,'BUT',26);
INSERT INTO But VALUES ('20224700','20220011','00281','00280','BUT',32);

INSERT INTO But VALUES ('20224800','20220026','00667',null,'BUT',27);
INSERT INTO But VALUES ('20224800','20220026','00659','00655','BUT',91);
INSERT INTO But VALUES ('20224800','20220016','00858','00839','BUT',5);

INSERT INTO But VALUES ('20224900','20220009','00239','00227','BUT',10);
INSERT INTO But VALUES ('20224900','20220009','00239','00234','BUT',46);
INSERT INTO But VALUES ('20224900','20220009','00234','00239','BUT',81);
INSERT INTO But VALUES ('20224900','20220018','00451','00442','BUT',76);

INSERT INTO But VALUES ('20225000','20220024','00604','00613','BUT',35);
INSERT INTO But VALUES ('20225000','20220024','00603',null,'BUT',57);
INSERT INTO But VALUES ('20225000','20220010','00618',null,'CSC',77);

INSERT INTO But VALUES ('20225100','20220001','00010','00011','BUT',44);
INSERT INTO But VALUES ('20225100','20220001','00011','00012','BUT',74);
INSERT INTO But VALUES ('20225100','20220001','00011','00027','BUT',91);
INSERT INTO But VALUES ('20225100','20220029','00738',null,'PENO',99);

INSERT INTO But VALUES ('20225200','20220003','00063','00077','BUT',38);
INSERT INTO But VALUES ('20225200','20220003','00064','00075','BUT',48);
INSERT INTO But VALUES ('20225200','20220003','00072','00075','BUT',57);

INSERT INTO But VALUES ('20225300','20220013','00350','00347','BUT',43);
INSERT INTO But VALUES ('20225300','20220006','00140','00142','BUT',55);

INSERT INTO But VALUES ('20225400','20220005','00129','00119','BUT',07);
INSERT INTO But VALUES ('20225400','20220005','00119',null,'PENO',13);
INSERT INTO But VALUES ('20225400','20220005','00118','00112','BUT',29);
INSERT INTO But VALUES ('20225400','20220005','00116','00129','BUT',36);
INSERT INTO But VALUES ('20225400','20220026','00656',null,'BUT',76);

INSERT INTO But VALUES ('20225600','20220016','00863','00848','BUT',17);
INSERT INTO But VALUES ('20225600','20220016','00840','00845','BUT',33);
INSERT INTO But VALUES ('20225600','20220016','00863','00839','BUT',51);
INSERT INTO But VALUES ('20225600','20220016','00842','00863','BUT',55);
INSERT INTO But VALUES ('20225600','20220016','00863','00848','BUT',67);
INSERT INTO But VALUES ('20225600','20220016','00852','00842','BUT',90);
INSERT INTO But VALUES ('20225600','20220014','00357',null,'BUT',58);

INSERT INTO But VALUES ('20225700','20220006','00152','00154','BUT',117);
INSERT INTO But VALUES ('20225700','20220005','00119','00116','BUT',106);

INSERT INTO But VALUES ('20225800','20220009','00236','00228','BUT',83);
INSERT INTO But VALUES ('20225800','20220009','00236','00237','BUT',101);
INSERT INTO But VALUES ('20225800','20220024','00620','00604','BUT',35);
INSERT INTO But VALUES ('20225800','20220024','00604',null,'PENO',73);

INSERT INTO But VALUES ('20225900','20220028','00721','00727','BUT',42);

INSERT INTO But VALUES ('20226000','20220002','00064',null,'PENO',54);
INSERT INTO But VALUES ('20226000','20220001','00009','00008','BUT',17);
INSERT INTO But VALUES ('20226000','20220001','00010','00008','BUT',78);

INSERT INTO But VALUES ('20226100','20220024','00604',null,'PENO',34);
INSERT INTO But VALUES ('20226100','20220024','00603',null,'BUT',39);
INSERT INTO But VALUES ('20226100','20220024','00603','00604','BUT',69);

INSERT INTO But VALUES ('20226200','20220001','00023',null,'BUT',05);
INSERT INTO But VALUES ('20226200','20220001','00013',null,'BUT',79);

INSERT INTO But VALUES ('20226300','20220006','00156','00140','BUT',07);
INSERT INTO But VALUES ('20226300','20220006','00154','00150','BUT',42);
INSERT INTO But VALUES ('20226300','20220028','00722',null,'BUT',09);

INSERT INTO But VALUES ('20226400','20220024','00604',null,'PENO',23);
INSERT INTO But VALUES ('20226400','20220024','00605','00614','BUT',36);
INSERT INTO But VALUES ('20226400','20220024','00604',null,'BUT',109);
INSERT INTO But VALUES ('20226400','20220001','00011',null,'PENO',80);
INSERT INTO But VALUES ('20226400','20220001','00011','00027','BUT',81);
INSERT INTO But VALUES ('20226400','20220001','00011',null,'PENO',118);

INSERT INTO Carton VALUES ('20220100','20220030','00757','JAUNE',15);
INSERT INTO Carton VALUES ('20220100','20220030','00775','JAUNE',22);
INSERT INTO Carton VALUES ('20220100','20220015','00402','JAUNE',29);
INSERT INTO Carton VALUES ('20220100','20220030','00768','JAUNE',36);
INSERT INTO Carton VALUES ('20220100','20220015','00399','JAUNE',56);
INSERT INTO Carton VALUES ('20220100','20220030','00767','JAUNE',78);

INSERT INTO Carton VALUES ('20220200','20220009','00220','JAUNE',56);
INSERT INTO Carton VALUES ('20220200','20220031','00789','JAUNE',94);
INSERT INTO Carton VALUES ('20220200','20220031','00788','JAUNE',96);

INSERT INTO Carton VALUES ('20220300','20220030','00773','JAUNE',20);
INSERT INTO Carton VALUES ('20220300','20220031','00792','JAUNE',30);
INSERT INTO Carton VALUES ('20220300','20220030','00770','JAUNE',47);
INSERT INTO Carton VALUES ('20220300','20220031','00797','JAUNE',52);
INSERT INTO Carton VALUES ('20220300','20220031','00794','JAUNE',87);
INSERT INTO Carton VALUES ('20220300','20220030','00779','JAUNE',91);

INSERT INTO Carton VALUES ('20220400','20220015','00399','JAUNE',57);

INSERT INTO Carton VALUES ('20220500','20220009','00222','JAUNE',52);

INSERT INTO Carton VALUES ('20220600','20220031','00788','JAUNE',66);

INSERT INTO Carton VALUES ('20220700','20220017','00413','JAUNE',25);
INSERT INTO Carton VALUES ('20220700','20220017','00414','JAUNE',48);

INSERT INTO Carton VALUES ('20220800','20220018','00434','JAUNE',11);
INSERT INTO Carton VALUES ('20220800','20220018','00440','JAUNE',13);
INSERT INTO Carton VALUES ('20220800','20220022','00551','JAUNE',40);
INSERT INTO Carton VALUES ('20220800','20220022','00545','JAUNE',48);
INSERT INTO Carton VALUES ('20220800','20220018','00445','JAUNE',51);
INSERT INTO Carton VALUES ('20220800','20220018','00455','JAUNE',100);

INSERT INTO Carton VALUES ('20220900','20220022','00546','JAUNE',48);
INSERT INTO Carton VALUES ('20220900','20220022','00541','ROUGE',86);
INSERT INTO Carton VALUES ('20220900','20220017','00429','JAUNE',94);
INSERT INTO Carton VALUES ('20220900','20220017','00413','JAUNE',95);

INSERT INTO Carton VALUES ('20221100','20220022','00560','JAUNE',29);
INSERT INTO Carton VALUES ('20221100','20220022','00550','JAUNE',61);

INSERT INTO Carton VALUES ('20221200','20220018','00436','JAUNE',43);
INSERT INTO Carton VALUES ('20221200','20220017','00425','JAUNE',77);
INSERT INTO Carton VALUES ('20221200','20220017','00419','JAUNE',83);
INSERT INTO Carton VALUES ('20221200','20220017','00431','JAUNE',96);

INSERT INTO Carton VALUES ('20221300','20220021','00521','JAUNE',67);
INSERT INTO Carton VALUES ('20221300','20220021','00518','JAUNE',75);
INSERT INTO Carton VALUES ('20221300','20220021','00523','JAUNE',79);
INSERT INTO Carton VALUES ('20221300','20220021','00525','JAUNE',82);
INSERT INTO Carton VALUES ('20221300','20220021','00531','JAUNE',88);
INSERT INTO Carton VALUES ('20221300','20220021','00534','JAUNE',92);

INSERT INTO Carton VALUES ('20221400','20220007','00182','JAUNE',29);
INSERT INTO Carton VALUES ('20221400','20220007','00178','JAUNE',56);
INSERT INTO Carton VALUES ('20221400','20220029','00753','JAUNE',76);

INSERT INTO Carton VALUES ('20221500','20220029','00743','JAUNE',15);
INSERT INTO Carton VALUES ('20221500','20220029','00731','JAUNE',16);
INSERT INTO Carton VALUES ('20221500','20220029','00736','JAUNE',19);
INSERT INTO Carton VALUES ('20221500','20220021','00521','JAUNE',20);
INSERT INTO Carton VALUES ('20221500','20220021','00517','JAUNE',49);

INSERT INTO Carton VALUES ('20221600','20220007','00165','JAUNE',22);
INSERT INTO Carton VALUES ('20221600','20220024','00598','JAUNE',43);
INSERT INTO Carton VALUES ('20221600','20220007','00177','JAUNE',50);
INSERT INTO Carton VALUES ('20221600','20220007','00179','JAUNE',66);
INSERT INTO Carton VALUES ('20221600','20220007','00188','JAUNE',89);

INSERT INTO Carton VALUES ('20221700','20220007','00602','JAUNE',49);
INSERT INTO Carton VALUES ('20221700','20220029','00739','JAUNE',78);

INSERT INTO Carton VALUES ('20221800','20220007','00167','JAUNE',16);
INSERT INTO Carton VALUES ('20221800','20220021','00524','JAUNE',28);
INSERT INTO Carton VALUES ('20221800','20220021','00528','JAUNE',34);
INSERT INTO Carton VALUES ('20221800','20220021','00530','JAUNE',52);
INSERT INTO Carton VALUES ('20221800','20220021','00516','JAUNE',81);
INSERT INTO Carton VALUES ('20221800','20220021','00517','JAUNE',91);
INSERT INTO Carton VALUES ('20221800','20220021','00532','JAUNE',97);

INSERT INTO Carton VALUES ('20221900','20220027','00688','JAUNE',24);
INSERT INTO Carton VALUES ('20221900','20220027','00682','JAUNE',86);

INSERT INTO Carton VALUES ('20222000','20220010','00259','JAUNE',55);
INSERT INTO Carton VALUES ('20222000','20220010','00266','JAUNE',80);
INSERT INTO Carton VALUES ('20222000','20220010','00257','JAUNE',94);

INSERT INTO Carton VALUES ('20222100','20220032','00824','JAUNE',26);
INSERT INTO Carton VALUES ('20222100','20220032','00834','JAUNE',64);
INSERT INTO Carton VALUES ('20222100','20220032','00823','JAUNE',93);

INSERT INTO Carton VALUES ('20222200','20220027','00681','JAUNE',20);
INSERT INTO Carton VALUES ('20222200','20220027','00696','JAUNE',23);
INSERT INTO Carton VALUES ('20222200','20220027','00006','JAUNE',43);

INSERT INTO Carton VALUES ('20222300','20220010','00260','JAUNE',04);
INSERT INTO Carton VALUES ('20222300','20220010','00246','JAUNE',57);
INSERT INTO Carton VALUES ('20222300','20220027','00699','JAUNE',75);

INSERT INTO Carton VALUES ('20222400','20220032','00824','JAUNE',26);
INSERT INTO Carton VALUES ('20222400','20220032','00834','JAUNE',64);
INSERT INTO Carton VALUES ('20222400','20220032','00823','JAUNE',93);

INSERT INTO Carton VALUES ('20222600','20220012','00313','JAUNE',68);
INSERT INTO Carton VALUES ('20222600','20220012','00310','JAUNE',97);

INSERT INTO Carton VALUES ('20222700','20220012','00305','JAUNE',41);
INSERT INTO Carton VALUES ('20222700','20220013','00327','JAUNE',44);
INSERT INTO Carton VALUES ('20222700','20220012','00303','JAUNE',61);
INSERT INTO Carton VALUES ('20222700','20220012','00313','JAUNE',70);
INSERT INTO Carton VALUES ('20222700','20220013','00329','JAUNE',84);
INSERT INTO Carton VALUES ('20222700','20220013','00331','JAUNE',93);

INSERT INTO Carton VALUES ('20222800','20220002','00033','JAUNE',37);
INSERT INTO Carton VALUES ('20222800','20220004','00087','JAUNE',44);
INSERT INTO Carton VALUES ('20222800','20220002','00036','JAUNE',58);
INSERT INTO Carton VALUES ('20222800','20220002','00034','JAUNE',60);

INSERT INTO Carton VALUES ('20222900','20220013','00329','JAUNE',39);
INSERT INTO Carton VALUES ('20222900','20220013','00328','JAUNE',44);
INSERT INTO Carton VALUES ('20222900','20220013','00347','JAUNE',45);

INSERT INTO Carton VALUES ('20223000','20220012','00304','JAUNE',76);

INSERT INTO Carton VALUES ('20223100','20220028','00706','JAUNE',78);

INSERT INTO Carton VALUES ('20223200','20220020','00497','JAUNE',09);
INSERT INTO Carton VALUES ('20223200','20220020','00501','JAUNE',53);
INSERT INTO Carton VALUES ('20223200','20220020','00504','JAUNE',56);
INSERT INTO Carton VALUES ('20223200','20220025','00640','JAUNE',81);
INSERT INTO Carton VALUES ('20223200','20220025','00623','JAUNE',83);

INSERT INTO Carton VALUES ('20223300','20220020','00504','JAUNE',28);
INSERT INTO Carton VALUES ('20223300','20220028','00713','JAUNE',95);

INSERT INTO Carton VALUES ('20223400','20220025','00632','JAUNE',52);
INSERT INTO Carton VALUES ('20223400','20220006','00142','JAUNE',56);
INSERT INTO Carton VALUES ('20223400','20220025','00625','JAUNE',85);
INSERT INTO Carton VALUES ('20223400','20220006','00146','JAUNE',85);

INSERT INTO Carton VALUES ('20223500','20220020','00505','JAUNE',66);

INSERT INTO Carton VALUES ('20223600','20220025','00631','JAUNE',07);
INSERT INTO Carton VALUES ('20223600','20220025','00642','JAUNE',26);
INSERT INTO Carton VALUES ('20223600','20220025','00624','JAUNE',47);
INSERT INTO Carton VALUES ('20223600','20220025','00626','JAUNE',84);

INSERT INTO Carton VALUES ('20223700','20220008','00209','JAUNE',36);
INSERT INTO Carton VALUES ('20223700','20220014','00356','JAUNE',64);
INSERT INTO Carton VALUES ('20223700','20220014','00357','JAUNE',83);

INSERT INTO Carton VALUES ('20223800','20220023','00569','JAUNE',07);
INSERT INTO Carton VALUES ('20223800','20220023','00575','JAUNE',49);
INSERT INTO Carton VALUES ('20223800','20220023','00583','JAUNE',64);

INSERT INTO Carton VALUES ('20223900','20220008','00193','JAUNE',24);
INSERT INTO Carton VALUES ('20223900','20220008','00201','JAUNE',30);
INSERT INTO Carton VALUES ('20223900','20220023','00578','JAUNE',49);
INSERT INTO Carton VALUES ('20223900','20220023','00571','JAUNE',90);

INSERT INTO Carton VALUES ('20224000','20220014','00377','JAUNE',50);
INSERT INTO Carton VALUES ('20224000','20220005','00117','JAUNE',52);

INSERT INTO Carton VALUES ('20224100','20220014','00355','JAUNE',15);
INSERT INTO Carton VALUES ('20224100','20220014','00369','JAUNE',34);
INSERT INTO Carton VALUES ('20224100','20220023','00587','JAUNE',47);
INSERT INTO Carton VALUES ('20224100','20220023','00569','JAUNE',56);
INSERT INTO Carton VALUES ('20224100','20220023','00579','JAUNE',66);
INSERT INTO Carton VALUES ('20224100','20220023','00575','JAUNE',81);
INSERT INTO Carton VALUES ('20224100','20220023','00576','JAUNE',82);
INSERT INTO Carton VALUES ('20224100','20220014','00362','JAUNE',95);
INSERT INTO Carton VALUES ('20224100','20220023','00571','JAUNE',95);
INSERT INTO Carton VALUES ('20224100','20220014','00374','JAUNE',99);
INSERT INTO Carton VALUES ('20224100','20220023','00583','JAUNE',100);

INSERT INTO Carton VALUES ('20224200','20220008','00215','JAUNE',06);
INSERT INTO Carton VALUES ('20224200','20220005','00123','JAUNE',07);
INSERT INTO Carton VALUES ('20224200','20220008','00205','JAUNE',28);
INSERT INTO Carton VALUES ('20224200','20220008','00209','JAUNE',32);
INSERT INTO Carton VALUES ('20224200','20220008','00200','JAUNE',81);
INSERT INTO Carton VALUES ('20224200','20220005','00119','JAUNE',85);
INSERT INTO Carton VALUES ('20224200','20220008','00200','ROUGE',93);

INSERT INTO Carton VALUES ('20224300','20220011','00293','JAUNE',57);
INSERT INTO Carton VALUES ('20224300','20220026','00657','JAUNE',88);

INSERT INTO Carton VALUES ('20224400','20220019','00479','JAUNE',45);
INSERT INTO Carton VALUES ('20224400','20220019','00469','JAUNE',49);
INSERT INTO Carton VALUES ('20224400','20220019','00485','JAUNE',57);
INSERT INTO Carton VALUES ('20224400','20220019','00478','JAUNE',91);
INSERT INTO Carton VALUES ('20224400','20220016','00850','JAUNE',91);
INSERT INTO Carton VALUES ('20224400','20220016','00845','JAUNE',95);

INSERT INTO Carton VALUES ('20224500','20220019','00477','JAUNE',21);
INSERT INTO Carton VALUES ('20224500','20220026','00653','JAUNE',27);
INSERT INTO Carton VALUES ('20224500','20220019','00461','JAUNE',73);
INSERT INTO Carton VALUES ('20224500','20220026','00667','JAUNE',77);

INSERT INTO Carton VALUES ('20224600','20220011','00277','JAUNE',06);
INSERT INTO Carton VALUES ('20224600','20220016','00855','JAUNE',38);
INSERT INTO Carton VALUES ('20224600','20220011','00287','JAUNE',44);
INSERT INTO Carton VALUES ('20224600','20220016','00848','JAUNE',77);
INSERT INTO Carton VALUES ('20224600','20220016','00841','JAUNE',89);

INSERT INTO Carton VALUES ('20224700','20220011','00282','JAUNE',19);
INSERT INTO Carton VALUES ('20224700','20220011','00280','JAUNE',60);
INSERT INTO Carton VALUES ('20224700','20220019','00481','JAUNE',86);
INSERT INTO Carton VALUES ('20224700','20220011','00290','JAUNE',87);
INSERT INTO Carton VALUES ('20224700','20220019','00485','JAUNE',99);
INSERT INTO Carton VALUES ('20224700','20220011','00273','JAUNE',100);
INSERT INTO Carton VALUES ('20224700','20220011','00292','JAUNE',100);

INSERT INTO Carton VALUES ('20224800','20220026','00666','JAUNE',36);
INSERT INTO Carton VALUES ('20224800','20220026','00659','JAUNE',92);

INSERT INTO Carton VALUES ('20224900','20220009','00237','JAUNE',60);
INSERT INTO Carton VALUES ('20224900','20220009','00238','JAUNE',87);

INSERT INTO Carton VALUES ('20225000','20220010','00266','JAUNE',15);
INSERT INTO Carton VALUES ('20225000','20220010','00246','JAUNE',38);

INSERT INTO Carton VALUES ('20225100','20220001','00009','JAUNE',31);
INSERT INTO Carton VALUES ('20225100','20220029','00747','JAUNE',47);
INSERT INTO Carton VALUES ('20225100','20220029','00731','JAUNE',88);
INSERT INTO Carton VALUES ('20225100','20220029','00731','JAUNE',88);

INSERT INTO Carton VALUES ('20225200','20220031','00786','JAUNE',76);

INSERT INTO Carton VALUES ('20225300','20220006','00144','JAUNE',90);
INSERT INTO Carton VALUES ('20225300','20220006','00139','JAUNE',116);

INSERT INTO Carton VALUES ('20225400','20220026','00653','JAUNE',44);

INSERT INTO Carton VALUES ('20225500','20220004','00106','JAUNE',76);
INSERT INTO Carton VALUES ('20225500','20220028','00708','JAUNE',90);

INSERT INTO Carton VALUES ('20225600','20220014','00374','JAUNE',43);
INSERT INTO Carton VALUES ('20225600','20220014','00370','JAUNE',59);

INSERT INTO Carton VALUES ('20225700','20220005','00111','JAUNE',25);
INSERT INTO Carton VALUES ('20225700','20220006','00147','JAUNE',31);
INSERT INTO Carton VALUES ('20225700','20220005','00114','JAUNE',68);
INSERT INTO Carton VALUES ('20225700','20220005','00113','JAUNE',77);
INSERT INTO Carton VALUES ('20225700','20220006','00152','JAUNE',117);

INSERT INTO Carton VALUES ('20225800','20220009','00219','JAUNE',43);
INSERT INTO Carton VALUES ('20225800','20220024','00602','JAUNE',43);
INSERT INTO Carton VALUES ('20225800','20220024','00607','JAUNE',45);
INSERT INTO Carton VALUES ('20225800','20220009','00236','JAUNE',47);
INSERT INTO Carton VALUES ('20225800','20220024','00619','JAUNE',76);
INSERT INTO Carton VALUES ('20225800','20220009','00227','JAUNE',76);
INSERT INTO Carton VALUES ('20225800','20220009','00228','JAUNE',88);
INSERT INTO Carton VALUES ('20225800','20220024','00599','JAUNE',89);
INSERT INTO Carton VALUES ('20225800','20220024','00604','JAUNE',100);
INSERT INTO Carton VALUES ('20225800','20220024','00613','JAUNE',101);
INSERT INTO Carton VALUES ('20225800','20220009','00224','JAUNE',104);
INSERT INTO Carton VALUES ('20225800','20220024','00598','JAUNE',109);
INSERT INTO Carton VALUES ('20225800','20220024','00600','JAUNE',112);
INSERT INTO Carton VALUES ('20225800','20220009','00239','JAUNE',128);
INSERT INTO Carton VALUES ('20225800','20220009','00229','JAUNE',128);
INSERT INTO Carton VALUES ('20225800','20220009','00239','ROUGE',128);

INSERT INTO Carton VALUES ('20225900','20220028','00722','JAUNE',70);
INSERT INTO Carton VALUES ('20225900','20220016','00853','JAUNE',87);
INSERT INTO Carton VALUES ('20225900','20220028','00723','JAUNE',91);
INSERT INTO Carton VALUES ('20225900','20220028','00723','ROUGE',93);

INSERT INTO Carton VALUES ('20226000','20220001','00008','JAUNE',43);
INSERT INTO Carton VALUES ('20226000','20220001','00012','JAUNE',46);
INSERT INTO Carton VALUES ('20226000','20220001','00023','JAUNE',82);
INSERT INTO Carton VALUES ('20226000','20220003','00061','JAUNE',90);

INSERT INTO Carton VALUES ('20226100','20220006','00137','JAUNE',32);
INSERT INTO Carton VALUES ('20226100','20220006','00144','JAUNE',32);
INSERT INTO Carton VALUES ('20226100','20220024','00607','JAUNE',68);
INSERT INTO Carton VALUES ('20226100','20220024','00613','JAUNE',71);

INSERT INTO Carton VALUES ('20226200','20220028','00719','JAUNE',27);

INSERT INTO Carton VALUES ('20226300','20220028','00710','JAUNE',69);
INSERT INTO Carton VALUES ('20226300','20220028','00717','JAUNE',84);

INSERT INTO Carton VALUES ('20226400','20220024','00618','JAUNE',52);
INSERT INTO Carton VALUES ('20226400','20220001','00015','JAUNE',55);
INSERT INTO Carton VALUES ('20226400','20220001','00027','JAUNE',87);
INSERT INTO Carton VALUES ('20226400','20220001','00010','JAUNE',95);
INSERT INTO Carton VALUES ('20226400','20220024','00602','JAUNE',98);
INSERT INTO Carton VALUES ('20226400','20220024','00599','JAUNE',114);
INSERT INTO Carton VALUES ('20226400','20220024','00598','JAUNE',116);
INSERT INTO Carton VALUES ('20226400','20220024','00617','JAUNE',128);

INSERT INTO Carton VALUES ('20224500','20220026','00648','ROUGE',101);

INSERT INTO Apparition VALUES ('00002','20226400',00,null);
INSERT INTO Apparition VALUES ('00023','20226400',00,71);
INSERT INTO Apparition VALUES ('00019','20226400',00,null);
INSERT INTO Apparition VALUES ('00005','20226400',00,113);
INSERT INTO Apparition VALUES ('00006','20226400',00,121);
INSERT INTO Apparition VALUES ('00009','20226400',00,null);
INSERT INTO Apparition VALUES ('00015','20226400',00,96);
INSERT INTO Apparition VALUES ('00008','20226400',00,71);
INSERT INTO Apparition VALUES ('00011','20226400',00,null);
INSERT INTO Apparition VALUES ('00010','20226400',00,41);
INSERT INTO Apparition VALUES ('00012','20226400',00,41);
INSERT INTO Apparition VALUES ('00013','20226400',41,null);
INSERT INTO Apparition VALUES ('00027','20226400',41,null);
INSERT INTO Apparition VALUES ('00021','20226400',71,null);
INSERT INTO Apparition VALUES ('00026','20226400',71,null);
INSERT INTO Apparition VALUES ('00014','20226400',96,null);
INSERT INTO Apparition VALUES ('00025','20226400',113,null);
INSERT INTO Apparition VALUES ('00004','20226400',121,null);

INSERT INTO Apparition VALUES ('00617','20226400',00,null);
INSERT INTO Apparition VALUES ('00597','20226400',00,121);
INSERT INTO Apparition VALUES ('00613','20226400',00,null);
INSERT INTO Apparition VALUES ('00607','20226400',00,null);
INSERT INTO Apparition VALUES ('00620','20226400',00,90);
INSERT INTO Apparition VALUES ('00614','20226400',00,116);
INSERT INTO Apparition VALUES ('00618','20226400',00,null);
INSERT INTO Apparition VALUES ('00601','20226400',00,102);
INSERT INTO Apparition VALUES ('00605','20226400',00,64);
INSERT INTO Apparition VALUES ('00603','20226400',00,103);
INSERT INTO Apparition VALUES ('00604','20226400',00,null);
INSERT INTO Apparition VALUES ('00602','20226400',64,null);
INSERT INTO Apparition VALUES ('00598','20226400',90,null);
INSERT INTO Apparition VALUES ('00599','20226400',102,null);
INSERT INTO Apparition VALUES ('00616','20226400',103,null);
INSERT INTO Apparition VALUES ('00600','20226400',116,null);
INSERT INTO Apparition VALUES ('00615','20226400',121,null);

SELECT H.NOM, H.PRENOM
FROM Humain H
JOIN Apparition A on H.NPERS = A.NPERS
JOIN Match M ON A.NMATH = M.NMATH
join Equipe E on H.NTEAM = E.NTEAM
WHERE M.RANG = 'Finale' AND A.ENTREE = 0 and E.CODE = 'FRA';

SELECT H.NOM, H.PRENOM, COUNT(CASE WHEN B.BUTEUR = H.NPERS THEN 1 END) as But, COUNT(CASE WHEN B.PASSEUR = H.NPERS THEN 1 END) as Passe
FROM Humain H
JOIN But B ON B.BUTEUR = H.NPERS OR B.PASSEUR = H.NPERS
JOIN Match M on M.NMATH = B.NMATH
WHERE M.RANG != 'Groupe' AND B.RANG != 'CSC'
GROUP BY H.NOM, H.PRENOM
HAVING COUNT(CASE WHEN B.BUTEUR = H.NPERS THEN 1 END) >= 1
   AND COUNT(CASE WHEN B.PASSEUR = H.NPERS THEN 1 END) >= 1
ORDER BY But DESC;

WITH counts AS (
  SELECT H.NOM, H.PRENOM, E.NOMEQ, COUNT(*) AS nB_Cartons,
         ROW_NUMBER() OVER (PARTITION BY H.NOM, H.PRENOM ORDER BY COUNT(*) DESC) AS rn
  FROM Humain H
  JOIN Arbitre A ON H.NPERS = A.NPRIN
  JOIN Match M ON M.NARBT = A.NARBT
  JOIN Carton C ON C.NMATH = M.NMATH
  JOIN Equipe E ON C.NTEAM = E.NTEAM
  GROUP BY H.NOM, H.PRENOM, E.NOMEQ
)
SELECT NOM, PRENOM, NOMEQ, nB_Cartons
FROM counts
WHERE rn = 1;
 
SELECT E.NOMEQ, 
       COUNT(CASE WHEN ((M.VAINQUEUR = 'Dom' AND M.NDOMI = E.NTEAM) OR (M.VAINQUEUR = 'Ext' AND M.NEXTE = E.NTEAM)) THEN 1 END) as Victoire, 
       COUNT(CASE WHEN M.VAINQUEUR = 'Nul' THEN 1 END) as Nul, 
       COUNT(CASE WHEN ((M.VAINQUEUR = 'Dom' AND M.NEXTE = E.NTEAM) OR (M.VAINQUEUR = 'Ext' AND M.NDOMI = E.NTEAM)) THEN 1 END) as Defaite,
       SUM(CASE WHEN M.NDOMI = E.NTEAM THEN split_part(M.RESULTAT, '-', 1)::int ELSE split_part(M.RESULTAT, '-', 2)::int END) as ButPour, 
       SUM(CASE WHEN M.NEXTE = E.NTEAM THEN split_part(M.RESULTAT, '-', 1)::int ELSE split_part(M.RESULTAT, '-', 2)::int END) as ButContre
FROM Equipe E
JOIN Match M on M.NDOMI = E.NTEAM OR M.NEXTE = E.NTEAM
GROUP by E.NOMEQ
ORDER BY Victoire DESC;

commit;