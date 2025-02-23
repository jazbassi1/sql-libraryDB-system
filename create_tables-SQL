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
