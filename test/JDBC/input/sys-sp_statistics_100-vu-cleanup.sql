use master
go

--cleanup
drop index sys_sp_statistics_100_vu_prepare_i1 on sys_sp_statistics_100_vu_prepare_t1
go

drop index sys_sp_statistics_100_vu_prepare_i2 on sys_sp_statistics_100_vu_prepare_t2
go

drop table sys_sp_statistics_100_vu_prepare_t1
go

drop table sys_sp_statistics_100_vu_prepare_t2
go

drop table sys_sp_statistics_100_vu_prepare_t3
go

drop database sys_sp_statistics_100_vu_prepare_db1
go