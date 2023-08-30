--mixedcase database name
CREATE DATABASE DB_NAME_VU_PREPARE_test1;
GO

CREATE DATABASE DB_NAME_VU_PREPARE_Test4;
GO

CREATE DATABASE DB_NAME_VU_PREPARE_tEst3;
GO

--error throwing original_name 
CREATE DATABASE DB_NAME_VU_PREPARE_TesT1;
GO

--different syntax
CREATE DATABASE DB_NAME_VU_PREPARE_TesT2 ON
(NAME = data_one,
    FILENAME = 'C:\print.pdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
(NAME = data_two,
    FILENAME = 'print.pdf',
    SIZE = 5 MB,
    MAXSIZE = 25 MB,
    FILEGROWTH = 5 MB);
GO
