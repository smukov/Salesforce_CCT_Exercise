@isTest
private class Test_TaskServices {

	@isTest static void test_generateTasksForCases() {
		//Arrange
		Case newCase = new Case(Priority = 'High', Origin = 'New Contact');
		insert newCase;
		newCase = [SELECT Id, CreatedDate, Priority, CaseNumber, OwnerId, Origin FROM Case WHERE Id = :newCase.Id];
		newCase.ContactId = TestUtility.getFakeId(Contact.sObjectType);

		//Act
		List<Task> newTasks = TaskServices.generateTasksForCases(new Case[]{ newCase });

		//Assert
		System.assertEquals(1, newTasks.size());

		Task testTask = newTasks[0];
		System.assertEquals(newCase.Id, testTask.WhatId);
		System.assertEquals(newCase.ContactId, testTask.WhoId);
		System.assertEquals(newCase.OwnerId, testTask.OwnerId);
		System.assertEquals(newCase.CreatedDate.date().addDays(7), testTask.ActivityDate);
		System.assertEquals('Not Started', testTask.Status);
		System.assertEquals('Welcome call for ' + newCase.CaseNumber, testTask.Subject);
		System.assertEquals('Normal', testTask.Priority);
	}

	@isTest static void test_getDueDate() {
		//Arrange
		insert new Case[] {
			new Case(Priority = 'High'),
			new Case(Priority = 'Medium'),
			new Case(Priority = 'Low'),
		 	new Case()
		};
		Case[] newCases = [SELECT Id, CreatedDate, Priority FROM Case];

		//Act & Assert
		for(Case c : newCases){
			Date dueDate = TaskServices.getDueDate(c);
			if(c.Priority == 'High') { System.assertEquals(c.CreatedDate.date().addDays(7), dueDate); }
			else if(c.Priority == 'Medium') { System.assertEquals(c.CreatedDate.date().addDays(14), dueDate); }
			else if(c.Priority == 'Low') { System.assertEquals(c.CreatedDate.date().addDays(21), dueDate); }
			else { System.assertEquals(null, dueDate); }
		}
	}

}
