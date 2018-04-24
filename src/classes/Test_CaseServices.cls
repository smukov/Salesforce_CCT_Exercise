@isTest
private class Test_CaseServices {

	@isTest static void test_generateCasesForNewContacts() {
		//Arrange
		Contact newContact = new Contact(
			Id = TestUtility.getFakeId(Contact.sObjectType),
			AccountId = TestUtility.getFakeId(Account.sObjectType),
			OwnerId = TestUtility.getFakeId(User.sObjectType),
			Level__c = 'Primary'
		);

		//Act
		List<Case> newCases = CaseServices.generateCasesForNewContacts(new Contact[]{ newContact });

		//Assert
		System.assertEquals(1, newCases.size());

		Case testCase = newCases[0];
		System.assertEquals(newContact.Id, testCase.ContactId);
		System.assertEquals(newContact.AccountId, testCase.AccountId);
		System.assertEquals(newContact.OwnerId, testCase.OwnerId);
		System.assertEquals('New Contact', testCase.Origin);
		System.assertEquals('Working', testCase.Status);
		System.assertEquals('High', testCase.Priority);
	}

	@isTest static void test_getCasePriority() {
		System.assertEquals('High', CaseServices.getCasePriority(new Contact(Level__c = 'Primary')));
		System.assertEquals('Medium', CaseServices.getCasePriority(new Contact(Level__c = 'Secondary')));
		System.assertEquals('Low', CaseServices.getCasePriority(new Contact(Level__c = 'Tertiary')));
		System.assertEquals(null, CaseServices.getCasePriority(new Contact()));
	}

}
