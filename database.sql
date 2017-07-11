-- Export de la structure de la table.
CREATE TABLE IF NOT EXISTS `weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steamId` char(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `ammo` smallint(6) NOT NULL,
  `tint` smallint(6) NOT NULL,
  `components_1` varchar(50) DEFAULT NULL,
  `components_2` varchar(50) DEFAULT NULL,
  `components_3` varchar(50) DEFAULT NULL,
  `components_4` varchar(50) DEFAULT NULL,
  `components_5` varchar(50) DEFAULT NULL,
  `components_6` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `steamId` (`steamId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;