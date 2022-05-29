USE `Elidek`;
-- Age of researcher
CREATE VIEW Researcher_Age AS SELECT Res.Researcher_id, Res.Name, Res.Last_Name,  YEAR(NOW()) - YEAR(Res.Date_of_Birth) - (DATE_FORMAT(NOW(), '%m%d') < DATE_FORMAT(Res.Date_of_Birth, '%m%d')) AS Age FROM `Elidek`.`Researchers` AS Res;
-- Duration of Project
CREATE VIEW Duration AS SELECT P.Project_id, P.Title, YEAR(P.Ending_Date) - YEAR(P.Starting_Date) - (DATE_FORMAT(P.Ending_Date , '%m%d') < DATE_FORMAT(P.Starting_Date , '%m%d')) AS Duration FROM `Elidek`.`Projects` AS P; 
-- Projects per Researcher
CREATE VIEW Projects_Per_Researcher AS SELECT Res.`Researcher_id`,Res.`Name`,Res.`Last_Name`,COUNT(PR.`proj_id`) AS Projects_per_Researcher FROM `Elidek`.`Researchers` AS Res RIGHT JOIN `Elidek`.`works_in_proj` AS PR ON Res.Researcher_id = PR.`Researcher_id` GROUP BY Res.Researcher_id;
-- Gender of Researchers
CREATE VIEW Gender_of_Researchers AS SELECT Res.`Gender`, COUNT(Res.Gender) AS Researchers_Gender_Count FROM `Elidek`.`Researchers` AS Res GROUP BY Res.`Gender`;