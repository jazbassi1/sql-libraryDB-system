/*Find overdue books (not returned after 14 days)*/
SELECT books.title, members.name, loans.loan_date 
FROM loans
JOIN books ON loans.book_id = books.book_id
JOIN members ON loans.member_id = members.member_id
WHERE loans.return_date IS NULL AND loans.loan_date < CURDATE() - INTERVAL 14 DAY;

/*Stored procedure to borrow a book*/
DELIMITER //
CREATE PROCEDURE BorrowBook(IN member_id INT, IN book_id INT)
BEGIN
  INSERT INTO loans (member_id, book_id, loan_date) 
  VALUES (member_id, book_id, CURDATE());
  UPDATE books SET status = 'borrowed' WHERE book_id = book_id;
END //
DELIMITER ;
