
/*** Create a table */
CREATE TABLE student(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT ,
    name VARCHAR(20) UNIQUE,
    age INT DEFAULT 0,
    major VARCHAR(20),
    salary DECIMAL(4, 2) DEFAULT 0,
    date_of_birth DATE
);

CREATE TABLE school(
    id INT NOT NULL AUTO_INCREMENT,
    student_id FOREIGN KEY INT NOT NULL  REFERENCES student(id) ON DELETE CASCADE, -- there is also ON DELETE SET NULL
    name VARCHAR(20),
    PRIMARY KEY(id)
);

/*** 
or:

CREATE TABLE student(
    id INT,
    name VARCHAR(20),
    age INT,
    salary DECIMAL(4, 2),
    PRIMARY KEY(id)
);

*/


/*** Describe a table and output it in a nice format */
DESCRIBE student;

/*** Modify an existing table  and add a gpa column to that table */
ALTER TABLE student ADD gpa DECIMAL(3, 2);

/*** Modify an existing table and delete/drop the gpa column from that table */
ALTER TABLE student DROP COLUMN gpa;

/**** Insert data into table */
INSERT INTO student VALUES(1, 'Jack', 23, 'cs', 200000, '1900-1-1');

INSERT INTO student VALUES(3, 'Jane', 12, 'bio', 100, '2000-2-2');

INSERT INTO school(id, student_id, name) VALUES(1, 1, 'ABCSchool');

/**** Insert data into specific fields while leaving others */
INSERT INTO student(id, name) VALUES(2, 'Sam');


-- Updating a field value 
UPDATE student
SET name = 'Tom' WHERE name = 'Jack';

-- Deleting a record
DELETE FROM student WHERE name = 'Sam' AND id = 2;

/*** If we say:
    DELETE FROM student

    this will delete the whole table
*/


-- Ordering by 
SELECT * FROM student
ORDER BY ASC;

SELECT * FROM student 
ORDER BY id
LIMIT 1;


/**** To select data to be one of certain values */
SELECT * FROM student WHERE name IN ('Jack', 'Tom') AND major IN ('cs', 'bio');


/*** To read a field while renaming it */
SELECT name AS full_name FROM student;

/**** Select non repeating values */
SELECT DISTINCT age FROM student;


/**** Math functions */
SELECT COUNT(student.name) FROM student;
SELECT COUNT(student.age), age FROM student
GROUP BY age;


/*** selecting data matching a certain pattern */
SELECT * FROM student WHERE name LIKE '%Jack';

--To get data with the exact word Jane Tom in it
SELECT * FROM student WHERE name LIKE '%Jane%';

-- select all the people that were born in January
SELECT * FROM student WHERE date_of_birth LIKE '____-1%';

-- To combine data from multiple sources into the same column, we use the UNION operation
SELECT * FROM student
UNION
SELECT * FROM school;

-- To combine 2 tables to meet at a specific column
SELECT * FROM student
JOIN school
ON student.name;


-- We also have LEFT JOIN  and RIGHT JOIN
SELECT * FROM student
LEFT JOIN school ON student.name;

SELECT * FROM student
RIGHT JOIN school ON student.name;


-- Nested SQL queries, ex: get me all the students who are in ABCSchool
SELECT * FROM student IN (
    SELECT * FROM SCHOOL WHERE name = "ABCSchool"
);

--Defining Triggers
DELIMITER$$

CREATE TRIGGER my_trigger 
BEFORE INSERT ON school
FOR EACH ROW BEGIN
    INSERT INTO my_trigger VALUES('Added a new school');
END$$

DELIMITER;

-- Delete a table 
DROP student;
DROP school;


