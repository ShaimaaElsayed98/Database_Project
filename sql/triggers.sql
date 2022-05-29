USE `Elidek`;

delimiter //
CREATE TRIGGER bi_corp BEFORE INSERT 
ON `Elidek`.`Corporation`
	FOR EACH ROW
	IF NEW.`org_id` IN (SELECT `org_id` FROM `Elidek`.`Organization`) 
	THEN SIGNAL SQLSTATE '50051' SET MESSAGE_TEXT = 'An organization with the same id exists.';
	END IF; //
delimiter ;

delimiter //
CREATE TRIGGER bi_uni BEFORE INSERT 
ON `Elidek`.`University`
	FOR EACH ROW
	IF NEW.`org_id` IN (SELECT `org_id` FROM `Elidek`.`Organization`) 
	THEN SIGNAL SQLSTATE '50052' SET MESSAGE_TEXT = 'An organization with the same id exists.';
	END IF; //
delimiter ;

delimiter //
CREATE TRIGGER bi_rescent BEFORE INSERT 
ON `Elidek`.`Research_Center`
	FOR EACH ROW
	IF NEW.`org_id` IN (SELECT `org_id` FROM `Elidek`.`Organization`) 
	THEN SIGNAL SQLSTATE '50053' SET MESSAGE_TEXT = 'An organization with the same id exists.';
	END IF; //
delimiter ;

delimiter //
CREATE TRIGGER bi_projtit BEFORE INSERT 
ON `Elidek`.`Organization`
	FOR EACH ROW
	IF NEW.`org_id` IN (SELECT `org_id` FROM `Elidek`.`Organization`) 
	THEN SIGNAL SQLSTATE '50053' SET MESSAGE_TEXT = 'An organization with the same id exists.';
	END IF; //
delimiter ;

delimiter //
CREATE TRIGGER bi_prog BEFORE INSERT 
ON `Elidek`.`Programs`
	FOR EACH ROW
	IF NEW.`prog_id` IN (SELECT `prog_id` FROM `Elidek`.`Programs`) 
	THEN SIGNAL SQLSTATE '50030' SET MESSAGE_TEXT = 'Program with the same id exists.';
	END IF; //
delimiter ;

delimiter //
CREATE TRIGGER bi_eval BEFORE INSERT ON `Elidek`.`Evaluation`
	FOR EACH ROW
	IF NEW.`Evaluation_id` IN (SELECT `Evaluation_id` FROM `Elidek`.`Evaluation`)
	AND (NEW.`Researcher_id` IN (SELECT `Researcher_id`  FROM `Elidek`.`Evaluation`))
	AND (NEW.`Project_id` IN (SELECT `Project_id`  FROM `Elidek`.`Evaluation`)) THEN
	SIGNAL SQLSTATE '50040' SET MESSAGE_TEXT = 'An evaluation from this project was made by this research with the same id.';
	END IF; //
END;
delimiter ;

delimiter //
CREATE TRIGGER bi_eval_g BEFORE INSERT ON `Elidek`.`Evaluation`
	FOR EACH ROW
	IF NEW.`Grade`> 10 OR NEW.`Grade` < 0  THEN 
	SIGNAL SQLSTATE '50041' SET MESSAGE_TEXT = 'Grade must be a value 0 <= GRADE <= 10.';
	END IF;//
delimiter ;

delimiter //
CREATE TRIGGER bi_org BEFORE INSERT ON `Elidek`.`Organization`
	FOR EACH ROW
	IF NEW.`Org_id` IN (SELECT `Org_id` FROM `Elidek`.`Organization`) THEN
	SIGNAL SQLSTATE '50050' SET MESSAGE_TEXT = 'An organization with the same id exists.';
	END IF; //
END;
delimiter ;

delimiter //
CREATE TRIGGER bi_exec BEFORE INSERT ON `Elidek`.`Executives`
	FOR EACH ROW
	IF NEW.`exec_id` IN (SELECT `Elidek`.`exec_id` FROM `Elidek`.`Executives`) THEN
	SIGNAL SQLSTATE '50060' SET MESSAGE_TEXT = 'An executive already has the same id.';
	END IF; //
END;
delimiter ;

delimiter //
CREATE TRIGGER bi_orgphone BEFORE INSERT ON `Elidek`.`Organization_Phone_Number`
	FOR EACH ROW
	IF NEW.`No_id` IN (SELECT `Elidek`.`No_id` FROM `Elidek`.`Organization_Phone_Number`)
	AND (NEW.`t_org_id` IN (SELECT `Elidek`.`Org_id` FROM `Elidek`.`Organization`)) 
	THEN
	SIGNAL SQLSTATE '50070' SET MESSAGE_TEXT = 'A phone with the same id exists for this Organization.';
	END IF; //
END;
delimiter ;

delimiter //
CREATE TRIGGER bi_researcher BEFORE INSERT ON `Elidek`.`Researchers`
	FOR EACH ROW
	IF NEW.`Researcher_id` IN (SELECT `Elidek`.`Researcher_id` FROM `Elidek`.`Researchers`)
	THEN
	SIGNAL SQLSTATE '50080' SET MESSAGE_TEXT = 'A researcher with the same id exists.';
	END IF; //
END;
delimiter ;

delimiter //
CREATE TRIGGER bi_del BEFORE INSERT ON `Elidek`.`Deliverable_Projects`
	FOR EACH ROW
	IF NEW.`Deliv_id` IN (SELECT `Elidek`.`Deliv_id` FROM `Elidek`.`Deliverable_Projects`)
	AND (NEW.`Project_id` IN (SELECT `Elidek`.`Project_id` FROM `Elidek`.`Projects`))
	THEN
	SIGNAL SQLSTATE '50090' SET MESSAGE_TEXT = 'A deliverable for this project shares the same id.';
	END IF; //
END;
delimiter ;

delimiter //
CREATE TRIGGER bi_proj BEFORE INSERT ON `Elidek`.`Projects`
	FOR EACH ROW
	BEGIN
	IF NEW.`Project_id` IN (SELECT `Elidek`.`Project_id` FROM `Elidek`.`Projects`)
	THEN
	SIGNAL SQLSTATE '50100' SET MESSAGE_TEXT = 'A project shares the same id.';
	END IF;
	IF NEW.`Title` IN (SELECT `Title` FROM `Elidek`.`Projects`)
	THEN
	SIGNAL SQLSTATE '50101' SET MESSAGE_TEXT = 'A project with the same title exists.';
	END IF;
	IF DATEDIFF(NEW.`Starting_Date`, NEW.`Ending_Date`) > 4
	OR
	DATEDIFF(NEW.`Starting_Date`, NEW.`Ending_Date`) < 1
	THEN
	SIGNAL SQLSTATE '50102' SET MESSAGE_TEXT = 'A project should have be active for 1 to 4 years.';
	END IF; 
END;
delimiter ;

delimiter //
CREATE TRIGGER bi_wip BEFORE INSERT ON `Elidek`.`works_in_proj`
	FOR EACH ROW
	IF NEW.`Researcher_id` NOT IN (SELECT `Elidek`.`Researcher_id` FROM `Elidek`.`Works_for` INNER JOIN `Elidek`.`Projects` USING (`Org_id`))
	THEN
	SIGNAL SQLSTATE '50110' SET MESSAGE_TEXT = 'A researcher cannot work in a project outside of his organization.';
	END IF; //
END;
delimiter ;

delimiter //
CREATE TRIGGER bi_resage BEFORE INSERT ON `Elidek`.`Researchers`
	FOR EACH ROW
	BEGIN
	IF NEW.`Date_of_Birth` > DATE_SUB(CURRENT_DATE(), INTERVAL 18 YEAR) 
	THEN
	SIGNAL SQLSTATE '50081' SET MESSAGE_TEXT = 'A researcher cannot be younger than 18 years of age.';
	END IF; 
	IF NEW.`Gender`<> 'M'
	AND
	NEW.`Gender`<> 'F'
	AND 
	NEW.`Gender`<> 'N'
	THEN 
	SIGNAL SQLSTATE '50082' SET MESSAGE_TEXT = 'A researcher can be either Male, Female or Non-binary.';
	END IF; 
END;
delimiter ;
delimiter //
CREATE TRIGGER bi_scifi BEFORE INSERT ON `Elidek`.`Scientific_Fields`
	FOR EACH ROW
	BEGIN
	IF NEW.`sci_id` IN (SELECT `sci_id` FROM `Elidek`.`Scientific_Fields`)
	THEN
	SIGNAL SQLSTATE '50120' SET MESSAGE_TEXT = 'A scientific field with the same id exists.';
	END IF; 
	IF NEW.`Name` IN (SELECT `Name` FROM `Elidek`.`Scientific_Fields`)
	THEN
	SIGNAL SQLSTATE '50121' SET MESSAGE_TEXT = 'A scientific field with the same name exists.';
	END IF; 
END;
delimiter ;