DROP LOGIN PassWordUser;
GO

-- test for drop login with upn format
DROP LOGIN [aduser@AD];
GO

DROP LOGIN [ad\Aduser];
GO

DROP LOGIN [ad\Aduserdb];
GO

DROP LOGIN [ad\Aduserlanguage];
GO

DROP LOGIN [ad\Aduserdblanguage];
GO

DROP LOGIN [ad\AduserdbEnglish];
GO

DROP LOGIN [ad\Aduseroption];
GO

DROP LOGIN [babel\aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa]
GO

-- test for non-existent login
DROP LOGIN [babel\non_existent_login]
GO

-- drop login with different casing
DROP LOGIN UserPassword;
GO

DROP LOGIN [BabeL\DupLicate];
GO

DROP LOGIN [Babel\DuplicateDefaultDB];
GO

-- test drop logins for logins with different language names
-- Arabic
DROP LOGIN [babel\كلب];
GO

-- Mongolian
DROP LOGIN [babel\өглөө];
GO

-- Greek
DROP LOGIN [babel\ελπίδα];
GO

-- Chinese
DROP LOGIN [babel\爱];
GO

DROP DATABASE ad_db;
GO
