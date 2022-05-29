SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Elidek
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Elidek` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;

USE `Elidek` ;
-- -----------------------------------------------------
-- Table `Elidek`.`Programs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Programs` (
  `prog_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(90) NULL,
  `Department` VARCHAR(90) NULL,
  PRIMARY KEY (`prog_id`))
ENGINE = InnoDB;
	
    	

-- -----------------------------------------------------
-- Table `Elidek`.`Organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Organization` (
  `Org_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Abbreviation` VARCHAR(45) NOT NULL,
  `Address_Street` VARCHAR(45) NULL,
  `Address_Street_Number` INT NULL,
  `Address_Postal_Code` INT(5) NULL,
  `Address_City` VARCHAR(45) NULL,
  PRIMARY KEY (`Org_id`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `Elidek`.`Executives`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Executives` (
  `exec_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NULL,
  `Last_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`exec_id`))
ENGINE = InnoDB;
-- CHECK (`Date_of_Birth` < DATE_SUB(CURDATE(),INTERVAL 18 YEAR)) AND (`Date_of_Birth` > DATE_SUB(CURDATE(),INTERVAL 67 YEAR))
-- -----------------------------------------------------
-- Table `Elidek`.`Researchers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Researchers` (
  `Researcher_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Gender` VARCHAR(1) NOT NULL,
  `Date_of_Birth` DATE NULL,
  PRIMARY KEY (`Researcher_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elidek`.`Projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Projects` (
  `Project_id` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(150) NOT NULL,
  `Summary` TEXT NULL,
  `Funding` INT NULL,
  `Starting_Date` DATE NULL,
  `Ending_Date` DATE NULL,
  `org_mgmt` INT NULL,
  `exec_id` INT UNSIGNED NOT NULL,
  `prog_id` INT UNSIGNED NOT NULL,
  `sci_supervisor` INT NOT NULL,
  PRIMARY KEY (`Project_id`),
  INDEX `org_id_idx` (`org_mgmt` ASC) VISIBLE,
  INDEX `exec_id_idx` (`exec_id` ASC) VISIBLE,
  INDEX `prog_id_idx` (`prog_id` ASC) VISIBLE,
  INDEX `researcher_id_idx` (`sci_supervisor` ASC) VISIBLE,
  CONSTRAINT `org_id`
    FOREIGN KEY (`org_mgmt`)
    REFERENCES `Elidek`.`Organization` (`Org_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `exec_id`
    FOREIGN KEY (`exec_id`)
    REFERENCES `Elidek`.`Executives` (`exec_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `prog_id`
    FOREIGN KEY (`prog_id`)
    REFERENCES `Elidek`.`Programs` (`prog_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `researcher_id`
    FOREIGN KEY (`sci_supervisor`)
    REFERENCES `Elidek`.`Researchers` (`Researcher_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elidek`.`Organization_Phone_Number`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Organization_Phone_Number` (
	`No_id` INT NOT NULL AUTO_INCREMENT,
	`t_org_id` INT NOT NULL,
	`Org_Phone_number` VARCHAR(14) NULL,
	PRIMARY KEY (`No_id`,`t_org_id`),
	CONSTRAINT `t_org_id`
		FOREIGN KEY(`t_org_id`)
		REFERENCES `Elidek`.`Organization` (`Org_id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
	ENGINE= InnoDB;



-- -----------------------------------------------------
-- Table `Elidek`.`Deliverable_Projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Deliverable_Projects` (
  `Deliv_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Project_id` INT NOT NULL,
  `Title` VARCHAR(45) NULL,
  `Summary` TEXT NULL,
  `Date_of_delivery` DATE NULL,
  PRIMARY KEY (`Deliv_id`,`Project_id`),
  INDEX `Project_id_idx` (`Project_id` ASC) VISIBLE,
  CONSTRAINT `Project_id`
    FOREIGN KEY (`Project_id`)
    REFERENCES `Elidek`.`Projects` (`Project_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elidek`.`University`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`University` (
  `org_id` INT NOT NULL PRIMARY KEY,
  `Ministry_Funding` FLOAT NULL,
  INDEX `org_id_idx` (`org_id` ASC) VISIBLE,
  CONSTRAINT `on_id_uni`
    FOREIGN KEY (`org_id`)
    REFERENCES `Elidek`.`Organization` (`Org_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elidek`.`Research_Center`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Research_Center` (
  `org_id` INT NOT NULL PRIMARY KEY,
  `Ministry_funding` FLOAT NULL,
  `Private_Sector_funding` FLOAT NULL,
  INDEX `org_id_idx` (`Org_id` ASC) VISIBLE,
  CONSTRAINT `on_id_res`
    FOREIGN KEY (`org_id`)
    REFERENCES `Elidek`.`Organization` (`Org_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elidek`.`Corporation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Corporation` (
  `org_id` INT NOT NULL PRIMARY KEY,
  `Equity_Capital` FLOAT NULL,
  INDEX `org_id_idx` (`org_id` ASC) VISIBLE,
  CONSTRAINT `org_id_cor`
    FOREIGN KEY (`org_id`)
    REFERENCES `Elidek`.`Organization` (`Org_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elidek`.`Scientific_Fields`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Scientific_Fields` (
  `sci_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`sci_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elidek`.`Scientific_Fields_of_Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Scientific_Fields_of_Project` (
  `sci_id` INT UNSIGNED NOT NULL,
  `Project_id` INT NOT NULL,
  INDEX `project1_idx` (`Project_id` ASC) VISIBLE,
  PRIMARY KEY (`sci_id`,`Project_id`),
  CONSTRAINT `sci_id`
    FOREIGN KEY (`sci_id`)
    REFERENCES `Elidek`.`Scientific_Fields` (`sci_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `project1`
    FOREIGN KEY (`Project_id`)
    REFERENCES `Elidek`.`Projects` (`Project_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elidek`.`Works_for`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Works_for` (
  `org_id` INT NOT NULL,
  `Researcher_id` INT NOT NULL,
  `Start_date` DATE NOT NULL,
  PRIMARY KEY (`org_id`,Researcher_id),
  INDEX `org_id_idx` (`org_id` ASC) VISIBLE,
  CONSTRAINT `researcher`
    FOREIGN KEY (`Researcher_id`)
    REFERENCES `Elidek`.`Researchers` (`Researcher_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `org4`
    FOREIGN KEY (`org_id`)
    REFERENCES `Elidek`.`Organization` (`Org_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Elidek`.`works_in_proj` (
  `proj_id` INT NOT NULL,
  `Researcher_id` INT NOT NULL,
  PRIMARY KEY (`proj_id`,`Researcher_id`),
  CONSTRAINT `researcher_proj`
    FOREIGN KEY (`Researcher_id`)
    REFERENCES `Elidek`.`Researchers` (`Researcher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `project_work`
    FOREIGN KEY (`proj_id`)
    REFERENCES `Elidek`.`Projects` (`Project_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Elidek`.`Evaluation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elidek`.`Evaluation` (
  `Evaluation_id` INT UNSIGNED NOT NULL,
  `Project_id` INT NOT NULL,
  `Researcher_id` INT NOT NULL,
  `Grade` FLOAT NULL,
  `Date_of_evaluation` TIMESTAMP NULL,
  INDEX `researcher2_idx` (`Researcher_id` ASC) VISIBLE,
  PRIMARY KEY (`Evaluation_id`,`Researcher_id`,`Project_id`),
  CONSTRAINT `project3`
    FOREIGN KEY (`Project_id`)
    REFERENCES `Elidek`.`Projects` (`Project_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `researcher2`
    FOREIGN KEY (`Researcher_id`)
    REFERENCES `Elidek`.`Researchers` (`Researcher_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
