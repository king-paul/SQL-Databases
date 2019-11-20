-- Q1 Display the titles of all books on the subject "DataBases". Your result 
-- set should be sorted on the alphabetical order of the titles.
SELECT title
FROM book, subject
WHERE book.subjectID = subject.subjectID
AND subject.subjecttype like '%DataBase%';

-- Q2 Display
  -- 1. the number of books on the subject "DataBases".
SELECT count(title)
FROM book, subject
WHERE book.subjectID = subject.subjectID
AND subject.subjecttype like '%DataBase%';

  -- 2. the number of book copies on the subject "DataBases".
SELECT count(bookID)
FROM book_copy, book, subject
WHERE book_copy.bookdescID = book.bookdescID
AND book.subjectID = subject.subjectID
AND subject.subjecttype like '%DataBase%';

 -- Q3. Display the firstname and lastname of the authors who wrote books on the
 -- subject "Databases".

 
  -- 1. Write your query without using NATURAL JOINs
SELECT firstname, lastname
FROM author, written_by, book, subject
WHERE author.authorID = written_by.authorID
AND written_by.bookdescID = book.bookdescID
AND book.subjectID = subject.subjectID 
AND subject.subjecttype like '%DataBase%';

 -- 2 Write your query using NATURAL JOINs
SELECT DISTINCT firstname, lastname
FROM (select * from author
NATURAL JOIN written_by), book, subject
WHERE author.authorID = written_by.authorID
AND written_by.bookdescID = book.bookdescID
AND book.subjectID = subject.subjectID 
AND subject.subjecttype like '%DataBase%';

-- Q4. Whor translated the "book "American Electrician's Handbook"? Display the
-- firstname, middlenames, and lastname of the translator.
SELECT firstname, middlename, lastname
FROM author, written_by, book
WHERE book.title = 'American Electrician''s Handbook'
AND book.bookdescID = written_by.bookdescID
AND role = 'Translator'
AND written_by.authorID = author.authorID;
-- This book is not in the database

-- Q5 Display the firstname and lastname of the people who returned books late
SELECT person.firstname, person.lastname
FROM person, borrow
WHERE person.personID = borrow.personID
AND returndate > duedate;

-- Q6 Display the firstname and lastname of the people who returned books more
-- than 7 days late
SELECT person.firstname, person.lastname
FROM person, borrow
WHERE person.personID = borrow.personID
AND returndate > duedate + 7;

-- 7 Display the titles of books that havn't been borrowed
SELECT DISTINCT book.title
FROM book, book_copy
WHERE book.bookdescID = book_copy.bookdescID
AND book_copy.bookID NOT IN (SELECT bookID FROM borrow_copy);

/* 8 A borrower wants to borrow the book titled "PRINCIPLES AND PRACTICE OF 
DATABSE SYSTEMS", but all of its copies are already borrowed by others. Write
two queries to display other reccomended titles usging the follwing methods. */ 
  -- 1. Using partial matchin for the inclusion of the word "DATABASE" in the
  -- book title
SELECT title
FROM book
WHERE title like '%DATABASE%'
AND title != 'PRINCIPLES AND PRACTICE OF DATABASE SYSTEMS';

  --2. By searching of other books written by the same author (i.e. the author
  --of "PRINCIPLES AND PRACTICE OF DATABASE SYSTEMS")
SELECT author.*
FROM author, written_by, book
WHERE author.authorID = written_by.authorID
AND written_by.bookdescID = book.bookdescID
AND book.title = 'PRINCIPLES AND PRACTICE OF DATABASE SYSTEMS';

SELECT book.title
FROM book, written_by, author
WHERE book.bookdescID = written_by.bookdescID
AND written_by.authorID = author.authorID
AND author.authorID = '2492';

/* 9 Display the list of publishers who have published books on the subject
"DataBases". Your query should display publisher's full name, along with book
titles they published. Please note that, these publishers may have published
books in other subjects too. However, your query should only display book titles
in DataBases subject. */
Select publisher.publisherfullname, book.title
From publisher, published_by, subject, book
where publisher.publisherID = published_by.publisherID
AND published_by.bookdescID = book.bookdescID
AND book.subjectId = subject.subjectID
AND subject.subjecttype = 'DataBases';

-- 10 List the full names of publishers who have not published books on the
-- subject "Databases"
SELECT DISTINCT publisher.publisherfullname
FROM publisher, published_by, subject, book
WHERE publisher.publisherID = published_by.publisherID
AND published_by.bookdescID = book.bookdescID
AND book.subjectId = subject.subjectID
AND 'DataBases' NOT IN subject.subjecttype;