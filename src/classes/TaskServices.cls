public with sharing class TaskServices {

	/**
	 * Generates Tasks for provided Cases
	 */
	public static List<Task> generateTasksForCases(List<Case> cases){
		List<Task> newTasks = new List<Task>();

		for(Case c : cases){
			if(c.Origin == 'New Contact'){
				newTasks.add(new Task(
					Status = 'Not Started',
					Subject = 'Welcome call for ' + c.CaseNumber,
					Priority = 'Normal',
					OwnerId = c.OwnerId,
					ActivityDate = TaskServices.getDueDate(c),
					WhatId = c.Id,
					WhoId = c.ContactId
				));
			}
		}

		return newTasks;
	}

	/**
	 * Get Task due date based on Case Priority and Case Created Date
	 */
	public static Date getDueDate(Case c){

		if(c.Priority == 'High') { return c.CreatedDate.date().addDays(7); }
		if(c.Priority == 'Medium') { return c.CreatedDate.date().addDays(14); }
		if(c.Priority == 'Low') { return c.CreatedDate.date().addDays(21); }

		return null;
	}
}
