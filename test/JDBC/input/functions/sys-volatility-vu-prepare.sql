create function f1() 
returns int 
begin 
declare @a int; 
set @a = 1; 
return @a; 
end
go

create schema myschema;
go

create function myschema.f1() 
returns int 
begin 
declare @a int; 
set @a = 2; 
return @a; 
end
go