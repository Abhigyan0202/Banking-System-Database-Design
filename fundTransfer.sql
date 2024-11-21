CREATE DEFINER=`root`@`localhost` PROCEDURE `fundTransfer`(IN sender_number INT, IN receiver_number INT
,IN amount DOUBLE)
BEGIN
	DECLARE first_id INT;
    DECLARE second_id INT;
    DECLARE account_balance DOUBLE;
    select count(transaction_id) into first_id from transaction;
    SET first_id = first_id + 1;
    SET second_id = first_id + 1;
    select balance into account_balance FROM account where account_number = sender_number;
    IF amount <= account_balance THEN
		INSERT INTO transaction (transaction_id,account_number,time_stamp,amount,transaction_type)
        values (first_id,sender_number,NOW(),amount,'debit');
        INSERT INTO transaction (transaction_id,account_number,time_stamp,amount,transaction_type)
        values (second_id,receiver_number,NOW(),amount,'credit');
        UPDATE transaction set reference_id = second_id where transaction_id = first_id;
        UPDATE transaction set reference_id = first_id where transaction_id = second_id;
        UPDATE account SET balance = balance - amount WHERE account_number = sender_number;
        UPDATE account SET balance = balance + amount WHERE account_number = receiver_number;
	ELSE
     SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Balance Low. Transaction cannot proceed',
                MYSQL_ERRNO = 1001; 
    END IF;
        
END