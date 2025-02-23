CREATE TABLE books (
  book_id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  author VARCHAR(100),
  status ENUM('available', 'borrowed') DEFAULT 'available');

CREATE TABLE members (
  member_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE);

CREATE TABLE loans (
  loan_id INT PRIMARY KEY AUTO_INCREMENT,
  book_id INT,
  member_id INT,
  loan_date DATE NOT NULL,
  return_date DATE,
  FOREIGN KEY (book_id) REFERENCES books(book_id),
  FOREIGN KEY (member_id) REFERENCES members(member_id));

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
