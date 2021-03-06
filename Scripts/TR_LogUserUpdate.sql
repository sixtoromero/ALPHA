CREATE TRIGGER [dbo].[TR_LogUserUpdate]
ON [dbo].[Users]
FOR UPDATE
AS
	INSERT INTO AuditLogs (
			TableName
			,RegisterId
			,[Action]
			,[Data]
			,[Date]
			,UserId)
	SELECT 
			'Users', 
			Cast(inserted.Id AS NVARCHAR(10)), 
			'U', 
			(SELECT * FROM inserted FOR JSON AUTO),
			GETDATE(),
			inserted.Id
	FROM inserted
