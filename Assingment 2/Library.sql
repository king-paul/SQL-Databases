/*1. Give the bookdescID of books by authors whose surname starts
with “S” or by publishers whose name starts with “S”.*/
SELECT book.bookdescID--, author.lastname, publisher.publisherfullname
FROM book, written_by, author, publisher, published_by
-- join to author table
WHERE book.BOOKDESCID = written_by.BOOKDESCID
AND written_by.authorID = author.authorID
-- join to publisher table
AND book.BOOKDESCID = published_by.BOOKDESCID
AND published_by.publisherID = publisher.publisherID
-- find names that start with S
AND author.lastname like 'S%' OR publisher.publisherfullname like 'S%';

/* 2. With which publisher(s) the author Alfred Aho published his
book(s)? Display publishers' full names. You must not use any
subquery. */
SELECT publisher.publisherfullname --, author.FIRSTNAME, author.LASTNAME
FROM publisher, published_by, written_by, author
WHERE publisher.PUBLISHERID = published_by.PUBLISHERID
AND published_by.BOOKDESCID = written_by.BOOKDESCID
AND written_by.AUTHORID = author.AUTHORID
AND author.FIRSTNAME  = 'ALFRED'
AND author.LASTNAME = 'AHO';

/* 3. Who are the authors that published books with the MC GRAWHILL
publisher? Display the firstname and lastname of these
authors.*/
SELECT FIRSTNAME, MIDDLENAME, LASTNAME
FROM author, publisher, published_by, written_by
WHERE author.AUTHORID = written_by.AUTHORID
AND written_by.BOOKDESCID = published_by.BOOKDESCID
AND published_by.PUBLISHERID = publisher.PUBLISHERID
AND publisher.PUBLISHERFULLNAME = 'MC GRAW-HILL';

/* 4. Display the first name and lastname of authors who wrote more
than 3 books. Along with each name, display the number of
books as well.*/
SELECT author.FIRSTNAME, author.LASTNAME, COUNT(book.BOOKDESCID) 
AS totalBooks
FROM ((book
INNER JOIN written_by ON book.BOOKDESCID = written_by.BOOKDESCID)
INNER JOIN author ON author.AUTHORID = written_by.AUTHORID)
GROUP BY author.FIRSTNAME, author.LASTNAME
HAVING COUNT(book.BOOKDESCID) >= 3;

/* 5. Display the title of the book which has the largest number of
physical copies. If there are more than one book with the
largest number of copies, show them all. Your query should
show the number of copies along with the title. */
-- join the book title to the subquery
SELECT book.title, COUNT(book_copy.BOOKDESCID)
FROM (book JOIN book_copy ON book.BOOKDESCID = book_copy.BOOKDESCID)
GROUP BY book.title
HAVING COUNT (book_copy.BOOKDESCID) =
-- subquery to get the maximim of the count
(SELECT  MAX(COUNT(book_copy.BOOKDESCID)) AS total_copies
FROM (book JOIN book_copy
ON book.bookdescID = book_copy.bookdescID)
GROUP BY book.title);