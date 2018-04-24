public with sharing class ContactAfterInsertHandler implements TriggerHandler.HandlerInterface{
	public void handle() {
		List<Case> newCases = CaseServices.generateCasesForNewContacts((List<Contact>) Trigger.new);
		insert newCases;
	}
}
