DROP TABLE IF EXISTS sys_trigger_nestlevel_vu_t1
GO

CREATE TABLE sys_trigger_nestlevel_vu_t1(c1 int)
GO

CREATE TRIGGER sys_trigger_nestlevel_vu_trigger1 ON sys_trigger_nestlevel_vu_t1
AFTER INSERT
AS
BEGIN
   IF (trigger_nestlevel()) = 1
     BEGIN
        INSERT INTO sys_trigger_nestlevel_vu_t1(c1) VALUES (1); -- trigger_nestlevel should be 1 on first trigger call, so this should execute once & only once
     END
END
GO