--Sample Table
CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

DROP TABLE Persons;

--The TRUNCATE TABLE statement is used to delete the data inside a table, but not the table itself.
TRUNCATE TABLE Persons;
