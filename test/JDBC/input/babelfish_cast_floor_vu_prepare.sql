create view babelfish_cast_floor_bigint_v as select babelfish_cast_floor_bigint(cast ('123' as varchar(10)))
GO

create view babelfish_cast_floor_int_v as select babelfish_cast_floor_int(cast ('123' as varchar(10)));
GO

create view babelfish_cast_floor_smallint_v as select babelfish_cast_floor_smallint(cast ('123' as varchar(10)));
GO

create function babelfish_cast_floor_bigint_f() 
returns bigint
as
begin
	declare @a bigint = babelfish_cast_floor_bigint(cast ('123' as varchar(10)));
	return @a
end
GO

create function babelfish_cast_floor_int_f() 
returns int
as
begin
	declare @a int = babelfish_cast_floor_int(cast ('123' as varchar(10)));
	return @a
end
GO

create function babelfish_cast_floor_smallint_f() 
returns smallint
as
begin
	declare @a smallint = babelfish_cast_floor_smallint(cast ('123' as varchar(10)));
	return @a
end
GO