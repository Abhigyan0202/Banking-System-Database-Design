CREATE DEFINER=`root`@`localhost` PROCEDURE `bulkTransfer`(IN b_id INT,IN sender_number INT, 
IN bulk_amount DOUBLE)
BEGIN
	DECLARE total_amount DOUBLE;
    DECLARE number_of_accounts INT;
    DECLARE sender_balance DOUBLE;
    DECLARE bulk_transaction_id INT;
    SELECT COUNT(*) INTO number_of_accounts from account where branch_id = b_id;
    SET total_amount = bulk_amount * number_of_accounts;
    select count(*) into bulk_transaction_id from transaction;
    SET bulk_transaction_id = bulk_transaction_id + 1;
    SELECT balance INTO sender_balance from account where account_number = sender_number;
    IF sender_balance >= total_amount THEN
    INSERT INTO transaction (transaction_id,account_number,time_stamp,amount,transaction_type)
    values (bulk_transaction_id,sender_number,NOW(),total_amount,'debit');
    UPDATE account set balance = balance + bulk_amount where branch_id = b_id;
    UPDATE account set balance = balance - total_amount where account_number = sender_number;
    INSERT INTO transaction (account_number,time_stamp,amount,transaction_type,reference_id)
	SELECT 
	account_number,
	NOW() AS time_stamp,
	bulk_amount as amount,
	'credit' as transaction_type,
	bulk_transaction_id as reference_id
	from account where branch_id = b_id;
    
    ELSE
		SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Balance Low. Bulk Transaction cannot proceed',
                MYSQL_ERRNO = 1001; 
    
    END IF;
    
END