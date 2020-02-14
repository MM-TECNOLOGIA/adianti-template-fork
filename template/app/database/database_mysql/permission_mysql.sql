-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema permission
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `permission` ;

-- -----------------------------------------------------
-- Schema permission
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `permission` DEFAULT CHARACTER SET utf8 ;
USE `permission` ;

-- -----------------------------------------------------
-- Table `system_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `system_group` ;

CREATE TABLE IF NOT EXISTS `system_group` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `system_program`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `system_program` ;

CREATE TABLE IF NOT EXISTS `system_program` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  `controller` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `system_group_program`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `system_group_program` ;

CREATE TABLE IF NOT EXISTS `system_group_program` (
  `id` INT(11) NOT NULL,
  `system_group_id` INT(11) NOT NULL,
  `system_program_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_system_group_program_system_group_idx` (`system_group_id` ASC),
  INDEX `fk_system_group_program_system_program_idx` (`system_program_id` ASC),
  CONSTRAINT `fk_system_group_program_system_group`
    FOREIGN KEY (`system_group_id`)
    REFERENCES `system_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_system_group_program_system_program`
    FOREIGN KEY (`system_program_id`)
    REFERENCES `system_program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `system_preference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `system_preference` ;

CREATE TABLE IF NOT EXISTS `system_preference` (
  `id` VARCHAR(100) NOT NULL,
  `value` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `system_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `system_unit` ;

CREATE TABLE IF NOT EXISTS `system_unit` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  `connection_name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `system_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `system_user` ;

CREATE TABLE IF NOT EXISTS `system_user` (
  `id` INT(11) NOT NULL,
  `login` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `name` VARCHAR(100) NULL,
  `email` VARCHAR(100) NULL,
  `active` CHAR(1) NULL,
  `frontpage_id` INT(11) NOT NULL,
  `system_unit_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_system_user_system_unit_idx` (`system_unit_id` ASC),
  INDEX `fk_system_user_system_program_idx` (`frontpage_id` ASC),
  CONSTRAINT `fk_system_user_system_unit`
    FOREIGN KEY (`system_unit_id`)
    REFERENCES `system_unit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_system_user_system_program`
    FOREIGN KEY (`frontpage_id`)
    REFERENCES `system_program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `system_user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `system_user_group` ;

CREATE TABLE IF NOT EXISTS `system_user_group` (
  `id` INT(11) NOT NULL,
  `system_user_id` INT(11) NOT NULL,
  `system_group_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_system_user_group_system_user_idx` (`system_user_id` ASC),
  INDEX `fk_system_user_group_system_group_idx` (`system_group_id` ASC),
  CONSTRAINT `fk_system_user_group_system_user1`
    FOREIGN KEY (`system_user_id`)
    REFERENCES `system_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_system_user_group_system_group1`
    FOREIGN KEY (`system_group_id`)
    REFERENCES `system_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `system_user_program`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `system_user_program` ;

CREATE TABLE IF NOT EXISTS `system_user_program` (
  `id` INT(11) NOT NULL,
  `system_user_id` INT(11) NOT NULL,
  `system_program_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_system_user_program_system_user_idx` (`system_user_id` ASC),
  INDEX `fk_system_user_program_system_program_idx` (`system_program_id` ASC),
  CONSTRAINT `fk_system_user_program_system_user`
    FOREIGN KEY (`system_user_id`)
    REFERENCES `system_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_system_user_program_system_program`
    FOREIGN KEY (`system_program_id`)
    REFERENCES `system_program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `system_user_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `system_user_unit` ;

CREATE TABLE IF NOT EXISTS `system_user_unit` (
  `id` INT(11) NOT NULL,
  `system_user_id` INT(11) NOT NULL,
  `system_unit_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_system_user_unit_system_unit_idx` (`system_unit_id` ASC),
  INDEX `fk_system_user_unit_system_user_idx` (`system_user_id` ASC),
  CONSTRAINT `fk_system_user_unit_system_unit`
    FOREIGN KEY (`system_unit_id`)
    REFERENCES `system_unit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_system_user_unit_system_user`
    FOREIGN KEY (`system_user_id`)
    REFERENCES `system_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO system_group VALUES(1,'Admin');
INSERT INTO system_group VALUES(2,'Standard');

INSERT INTO system_program VALUES(1,'System Group Form','SystemGroupForm');
INSERT INTO system_program VALUES(2,'System Group List','SystemGroupList');
INSERT INTO system_program VALUES(3,'System Program Form','SystemProgramForm');
INSERT INTO system_program VALUES(4,'System Program List','SystemProgramList');
INSERT INTO system_program VALUES(5,'System User Form','SystemUserForm');
INSERT INTO system_program VALUES(6,'System User List','SystemUserList');
INSERT INTO system_program VALUES(7,'Common Page','CommonPage');
INSERT INTO system_program VALUES(8,'System PHP Info','SystemPHPInfoView');
INSERT INTO system_program VALUES(9,'System ChangeLog View','SystemChangeLogView');
INSERT INTO system_program VALUES(10,'Welcome View','WelcomeView');
INSERT INTO system_program VALUES(11,'System Sql Log','SystemSqlLogList');
INSERT INTO system_program VALUES(12,'System Profile View','SystemProfileView');
INSERT INTO system_program VALUES(13,'System Profile Form','SystemProfileForm');
INSERT INTO system_program VALUES(14,'System SQL Panel','SystemSQLPanel');
INSERT INTO system_program VALUES(15,'System Access Log','SystemAccessLogList');
INSERT INTO system_program VALUES(16,'System Message Form','SystemMessageForm');
INSERT INTO system_program VALUES(17,'System Message List','SystemMessageList');
INSERT INTO system_program VALUES(18,'System Message Form View','SystemMessageFormView');
INSERT INTO system_program VALUES(19,'System Notification List','SystemNotificationList');
INSERT INTO system_program VALUES(20,'System Notification Form View','SystemNotificationFormView');
INSERT INTO system_program VALUES(21,'System Document Category List','SystemDocumentCategoryFormList');
INSERT INTO system_program VALUES(22,'System Document Form','SystemDocumentForm');
INSERT INTO system_program VALUES(23,'System Document Upload Form','SystemDocumentUploadForm');
INSERT INTO system_program VALUES(24,'System Document List','SystemDocumentList');
INSERT INTO system_program VALUES(25,'System Shared Document List','SystemSharedDocumentList');
INSERT INTO system_program VALUES(26,'System Unit Form','SystemUnitForm');
INSERT INTO system_program VALUES(27,'System Unit List','SystemUnitList');
INSERT INTO system_program VALUES(28,'System Access stats','SystemAccessLogStats');
INSERT INTO system_program VALUES(29,'System Preference form','SystemPreferenceForm');
INSERT INTO system_program VALUES(30,'System Support form','SystemSupportForm');
INSERT INTO system_program VALUES(31,'System PHP Error','SystemPHPErrorLogView');
INSERT INTO system_program VALUES(32,'System Database Browser','SystemDatabaseExplorer');
INSERT INTO system_program VALUES(33,'System Table List','SystemTableList');
INSERT INTO system_program VALUES(34,'System Data Browser','SystemDataBrowser');
INSERT INTO system_program VALUES(35,'System Menu Editor','SystemMenuEditor');
INSERT INTO system_program VALUES(36,'System Request Log','SystemRequestLogList');
INSERT INTO system_program VALUES(37,'System Request Log View','SystemRequestLogView');
INSERT INTO system_program VALUES(38,'System Administration Dashboard','SystemAdministrationDashboard');
INSERT INTO system_program VALUES(39,'System Log Dashboard','SystemLogDashboard');
INSERT INTO system_program VALUES(40,'System Session dump','SystemSessionDumpView');

INSERT INTO system_unit VALUES(1,'Unit A','unit_a');
INSERT INTO system_unit VALUES(2,'Unit B','unit_b');

INSERT INTO system_user VALUES(1,'Administrator','admin','21232f297a57a5a743894a0e4a801fc3','admin@admin.net','Y',10,1);
INSERT INTO system_user VALUES(2,'User','user','ee11cbb19052e40b07aac0ca060c23ee','user@user.net','Y',7,1);