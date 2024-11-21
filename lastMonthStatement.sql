CREATE DEFINER=`root`@`localhost` PROCEDURE `lastMonthStatement`(IN a_n INT)
BEGIN
	SELECT * from transaction where account_number = a_n and time_stamp >= DATE_SUB(CURDATE(), 
    INTERVAL 1 MONTH);
END