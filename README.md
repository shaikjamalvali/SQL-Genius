![Application screenshot](./B+tree.jpg)
 
![Application screenshot](./archi.png)

 
![Application screenshot](./testing.png)
<br/>
<br/>
# SQL Genius
 SQLGenius is a versatile SQL tool designed to streamline database management and query execution. Whether you're a data analyst, developer, or database administrator, SQLGenius empowers you to interact with your databases efficiently and effectively.

Differences explaination:
=========================
 index tree is also implemented with B+ tree, not B tree.
   index tree utilizes InternalTableCell and LeafTableCell rather than InternalIndexCell and LeafIndexCell.
INDEX TREE == TABLE TREE 
    
       Index tree could only support dropping and inserting along with the table tree but not deleting due to complicity (implemented in DatabaseController).

    The key field of the table cells is implemented with type DBRecord, not int.


    The nodes of B+ Tree each has a pointer ParentPage pointing to its parent.
    leaf nodes of B+ Tree each has a pointer RightPage pointing to next leaf node on the right.

Architecture Explaination
=============

**Client**
=============

The Client module interacts directly with users, implementing the following functionalities:

Program flow control, i.e., "start and initialize -> receive command, process command, display command result loop -> exit" flow.


**Interpreter**
================
Receives and interprets user input commands, generates internal data structure representation of commands, checks the syntax and semantics of commands, executes correct commands using functions provided by the API layer, and displays execution results. Displays error messages for incorrect commands.

**API**
========
The API module is the core of the system, providing an interface for executing SQL statements, called by the Interpreter layer. The interface takes the internally represented command generated by the Interpreter layer as input, determines execution rules based on information provided by the Catalog Manager, and calls the corresponding interfaces provided by the Record Manager, Index Manager, and Catalog Manager for execution, finally returning execution results to the Interpreter module.

**Catalog Manager**
===================
Manages all schema information of the database, including:
=>
Definition information of all tables in the database, including table name, number of fields (columns) in the table, primary key, and indexes defined on the table.
Definition information of each field in the table, including field type, uniqueness, etc.
Definition of all indexes in the database, including the associated table, indexed field, etc.
The Catalog Manager also provides interfaces for accessing and operating the above information, used by the Interpreter and API modules.

**Record Manager**
===================
Manages data files of records in the record table. Its main functions include creating and deleting data files (triggered by table definition and deletion), inserting, deleting, and searching for records, and providing corresponding interfaces externally. Search operations support conditions with and without conditions (including equality, inequality, and range).

Data files consist of one or more data blocks, with block size equal to buffer block size. Each block contains one or more records. For simplicity, only fixed-length record storage is supported, and cross-block storage of records is not required.

**Index Manager**
==================
Implements B+ tree indexes, including creation, deletion (triggered by index definition and deletion), equality search, key insertion, key deletion, and provides corresponding interfaces externally.

Node size in B+ tree equals buffer block size. B+ tree fanout is calculated based on node size and index key size.

**Buffer Manager**
===================
Manages the buffer pool, with main functions:

Read specified data into the system buffer or write buffer data to files as needed.
Implement buffer replacement algorithms to choose suitable pages for replacement when the buffer is full.
Maintain page status in the buffer, such as modification status.
Provide pin functionality for buffer pages, locking pages to prevent replacement.
To improve disk I/O efficiency, buffer interaction with the file system is done in blocks, with block size being an integer multiple of the file system's interaction unit, typically set to 4KB or 8KB.

**DB Files**
=============
DB Files comprise all data files forming the database, including record data files, index data files, and Catalog data files.

**Data Types**
The system supports three basic data types: int, char(n), and float.

**Table Definition**
A table can have up to 32 attributes, each of which can be specified as unique. It supports defining a single attribute as the primary key.

**Index Creation and Deletion**
The system automatically creates B+ tree indexes for primary attributes of a table. Users can specify the creation/deletion of B+ tree indexes for attributes declared as unique using SQL statements. Thus, all B+ tree indexes are single-attribute and single-value.

**Record Retrieval**
Users can query records using multiple conditions connected by 'and', supporting equality and range queries.


<br/>
<br/>
The system supports inserting one record at a time and deleting one or multiple records at a time.


STEPS
======
install dotnet SDK  https://dotnet.microsoft.com/en-us/download
in commandprompt use==> dotnet run
and then use database ==> use database db_name;
then you can run queries and executile files from sql here now 

possible SQL Quires:-
=====================
*,drop ,insert,delete, conditional printing, exit,flush,table creating,use database,drop db,show tables,
<br/>
create table student (
    sno char(8),
    sname char(16) unique,
    sage int,
    sgender char (1),
    primary key ( sno )
); 
<br/> 
create index stunameidx on student ( sname );
<br/>
drop index stunameidx;
<br/>
show tables;
<br/>
select * from student;
<br/>
select * from student where sno = '88888888';
<br/>
select * from student where sage > 20 and sgender = 'F';
<br/>
select * from student where sno = '88888888' or sage > 20 and sgender = 'F';
<br/>
select * from student where sage > (20 + 2) / 3;
<br/>
insert into student values ('12345678','wy',22,'M');
<br/>
delete from student;
<br/>
delete from student where sno = '88888888';
<br/>
//ensure writing back all dirty pages
<br/>
exit
<br/>
// write all pages back to disk
<br/>
flush
