create user win_admin for login [pnq\admin]
GO

select login_name from sys.babelfish_authid_user_ext where rolname = 'master_win_admin';
GO

create user win_test for login [def\test]
GO

select login_name from sys.babelfish_authid_user_ext where rolname = 'win_test';
GO

drop user win_test;
GO

drop user win_admin;
GO

drop login [def\test];
GO

drop login [pnq\admin];
GO

exec babelfish_truncate_domain_mapping_table;
GO
