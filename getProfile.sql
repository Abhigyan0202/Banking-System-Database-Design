CREATE DEFINER=`root`@`localhost` PROCEDURE `getProfile`(IN c_id INT)
BEGIN
	DECLARE loan_count INT;
    SELECT count(*) into loan_count from customer_account c
    INNER JOIN account a on c.account_number = a.account_number
    INNER join loan on a.account_number = loan.account_number 
    WHERE customer_id = c_id;
    
    IF loan_count > 0 THEN
    select a.account_number,a.balance, loan_id, loan_amount from customer_account c
    INNER JOIN account a on c.account_number = a.account_number
    LEFT join loan on a.account_number = loan.account_number 
    WHERE customer_id = c_id;
    ELSE
	select customer_id, a.account_number,account_type,balance
    from customer_account c INNER JOIN account a on c.account_number = a.account_number
    where customer_id=c_id ;
    END IF;
     
END