CREATE TRIGGER [dbo].[TR_ContacByCorrespondencesInsert]
ON Correspondences
FOR INSERT
AS	
	DECLARE @UserId INT

	DECLARE @SenderId INT
	DECLARE @AddresseeId INT	
	
	SELECT @SenderId = inserted.SenderId, @AddresseeId = inserted.AddresseeId FROM inserted

	IF NOT EXISTS (SELECT 0 FROM Contacts WHERE IdUserContact = @SenderId AND UserId = @UserId)
	BEGIN
		INSERT INTO Contacts (
				IdUserContact
				,[Date]
				,UserId)
		SELECT 			
				@SenderId,
				GETDATE(),
				inserted.UserId
		FROM inserted
	END

	IF NOT EXISTS (SELECT 0 FROM Contacts WHERE IdUserContact = @AddresseeId AND UserId = @UserId)
	BEGIN
		INSERT INTO Contacts (
				IdUserContact
				,[Date]
				,UserId)
		SELECT 			
				@AddresseeId,
				GETDATE(),
				inserted.UserId
		FROM inserted
	END