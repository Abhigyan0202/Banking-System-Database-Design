CREATE DEFINER=`root`@`localhost` PROCEDURE `withdraw`(IN a_n INT,IN amount DOUBLE)
BEGIN
	DECLARE account_balance DOUBLE;
    DECLARE t_id INT;
    SELECT balance into account_balance from account where account_number = a_n;
    SELECT COUNT(*) into t_id FROM transaction;
    SET t_id = t_id + 1;
    IF account_balance >= amount THEN
		INSERT INTO transaction (transaction_id,account_number,time_stamp,amount,transaction_type)
        values (t_id,a_n,NOW(),amount,'debit');
        UPDATE account SET balance = balance - amount where account_number = a_n;
	ELSE 
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Balance Low. Withdrawl cannot proceed',
                MYSQL_ERRNO = 1001; 
	END IF ;
    
END