CREATE TABLE sys_check_constraints_vu_prepare_t2
(
column_a bit default 0,
column_b varchar(5) CHECK (column_b <> 'wrong'),
CHECK (column_a = 0)
)
GO