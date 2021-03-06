CREATE TRIGGER TR_LogCorrespondencesInsert
ON Correspondences
FOR INSERT
AS

	INSERT INTO AuditLogs (
			TableName
			,RegisterId
			,[Action]
			,[Data]
			,[Date]
			,UserId)
	SELECT 
			'Correspondences', 
			inserted.Consecutive, 
			'I', 
			(SELECT * FROM inserted FOR JSON AUTO), 
			GETDATE(),
			inserted.UserId
	FROM inserted
