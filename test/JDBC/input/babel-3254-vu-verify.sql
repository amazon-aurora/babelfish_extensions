sp_procedure_params_100_managed 'babel_3254_p1'
go

sp_procedure_params_100_managed 'babel_3254_p2'
go

sp_procedure_params_100_managed 'babel_3254_p3'
go

sp_procedure_params_100_managed 'babel_3254_p4'
go

sp_procedure_params_100_managed 'babel_3254_p5'
go

-- will result no rows as babel_3254_p6 is in babel_3254_s1 schema
sp_procedure_params_100_managed 'babel_3254_p6'
go

sp_procedure_params_100_managed @procedure_name = 'babel_3254_p6', @procedure_schema = 'babel_3254_s1'
go

sp_procedure_params_100_managed @procedure_name = 'babel_3254_p1', @group_number = 1
go

-- group number anything other than 1 should return no rows
sp_procedure_params_100_managed @procedure_name = 'babel_3254_p1', @group_number = 2
go

sp_procedure_params_100_managed @procedure_name = 'babel_3254_p2', @group_number = 3
go

sp_procedure_params_100_managed @procedure_name = 'babel_3254_p3', @group_number = 4
go

sp_procedure_params_100_managed @procedure_name = 'babel_3254_p4', @group_number = 5
go

sp_procedure_params_100_managed @procedure_name = 'babel_3254_p5', @group_number = 6
go

sp_procedure_params_100_managed @procedure_name = 'babel_3254_p1', @parameter_name = '@a'
go

sp_procedure_params_100_managed @procedure_name = 'babel_3254_p2', @parameter_name = '@b'
go

sp_procedure_params_100_managed @procedure_name = 'babel_3254_p3', @parameter_name = '@c'
go

sp_procedure_params_100_managed @procedure_name = 'babel_3254_p4', @parameter_name = '@d'
go

sp_procedure_params_100_managed @procedure_name = 'babel_3254_p5', @parameter_name = '@e'
go


