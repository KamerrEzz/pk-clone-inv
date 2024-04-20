CREATE TABLE `pk-clone-inv` (
	`identifier` CHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`inventory` LONGTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`mode` ENUM('temp','no') NOT NULL DEFAULT 'temp' COLLATE 'utf8mb4_unicode_ci',
	PRIMARY KEY (`identifier`) USING BTREE
)
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB
;
