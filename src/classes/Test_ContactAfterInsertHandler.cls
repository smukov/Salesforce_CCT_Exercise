@isTest
private class Test_ContactAfterInsertHandler {

	@isTest static void test_generateCasesAndTasksForNewContacts_bulk() {
		//Arrange
		Account[] accounts = new Account[]{
			new Account(Name = 'Test 1'),
			new Account(Name = 'Test 2')
		};
		insert accounts;

		List<Contact> newContacts = new List<Contact>();
		for(Integer i = 0; i <= 203;){
			newContacts.add(new Contact(
				LastName = 'Test' + i,
				Level__c = 'Primary',
				AccountId = accounts[0].Id
			));
			i++;

			newContacts.add(new Contact(
				LastName = 'Test' + i,
				Level__c = 'Secondary',
				AccountId = accounts[1].Id
			));
			i++;

			newContacts.add(new Contact(
				LastName = 'Test' + i,
				Level__c = 'Tertiary'
			));
			i++;
		}

		//Act
		Test.startTest();
		insert newContacts;
		Test.stopTest();

		//Assert
		newContacts = [
			SELECT Id, AccountId, LastName, Level__c, OwnerId
			FROM Contact
			ORDER BY LastName ASC
		];
		System.assertEquals(204, newContacts.size());

		//Assert if Cases have been created for new Contacts
		List<Case> newCases = [
			SELECT Id, ContactId, AccountId, Origin, Status, OwnerId, Priority, CaseNumber, CreatedDate
			FROM Case
			ORDER BY Contact.LastName ASC
		];
		System.assertEquals(204, newCases.size());

		for(Integer i = 0; i < newCases.size(); i++){
			Case newCase = newCases[i];
			Contact newContact = newContacts[i];

			System.assertEquals(newContact.Id, newCase.ContactId);
			System.assertEquals(newContact.AccountId, newCase.AccountId);
			System.assertEquals(newContact.OwnerId, newCase.OwnerId);
			System.assertEquals('New Contact', newCase.Origin);
			System.assertEquals('Working', newCase.Status);
			System.assertEquals(CaseServices.getCasePriority(newContact), newCase.Priority);
		}

		//Assert if tasks have been created for cases
		List<Task> newTasks = [
			SELECT Id, Status, Subject, Priority, OwnerId, ActivityDate, WhatId, WhoId
			FROM Task
			WHERE WhatId IN : newCases
		];
		System.assertEquals(204, newTasks.size());

		for(Integer i = 0; i < newCases.size(); i++){
			Case newCase = newCases[i];

			for(Task t : newTasks){
				if(t.WhatId == newCase.Id){
					System.assertEquals(newCase.ContactId, t.WhoId);
					System.assertEquals(newCase.OwnerId, t.OwnerId);
					System.assertEquals('Welcome call for ' + newCase.CaseNumber, t.Subject);
					System.assertEquals('Not Started', t.Status);
					System.assertEquals('Normal', t.Priority);
					System.assertEquals(TaskServices.getDueDate(newCase), t.ActivityDate);

					break;
				}
			}
		}
	}

}
