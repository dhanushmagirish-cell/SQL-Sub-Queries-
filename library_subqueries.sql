
-- Use the library database
USE librarydb;

-- ------------------------------
-- 1. Scalar Subquery
-- ------------------------------
-- Retrieve the book(s) with the maximum number of borrowings
SELECT *
FROM books
WHERE bookid = (
    SELECT bookid
    FROM borrowings
    GROUP BY bookid
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- ------------------------------
-- 2. Correlated Subquery
-- ------------------------------
-- List members who have borrowed more than 1 book
SELECT m.memberid, m.membername
FROM members m
WHERE (
    SELECT COUNT(*)
    FROM borrowings b
    WHERE b.memberid = m.memberid
) > 1;

-- ------------------------------
-- 3. Subquery with IN
-- ------------------------------
-- Get all books borrowed by 'Alice Smith'
SELECT *
FROM books
WHERE bookid IN (
    SELECT bookid
    FROM borrowings
    WHERE memberid = (
        SELECT memberid FROM members WHERE membername = 'Alice Smith'
    )
);

-- ------------------------------
-- 4. Subquery with EXISTS
-- ------------------------------
-- List members who have borrowed at least one book
SELECT m.memberid, m.membername
FROM members m
WHERE EXISTS (
    SELECT 1
    FROM borrowings b
    WHERE b.memberid = m.memberid
);

-- ------------------------------
-- 5. Subquery with =
-- ------------------------------
-- Find the author of '1984'
SELECT *
FROM authors
WHERE authorid = (
    SELECT authorid
    FROM books
    WHERE title = '1984'
);
