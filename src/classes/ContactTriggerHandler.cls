public with sharing class ContactTriggerHandler {

	final List<Contact> newRecords;
    final Map<Id, Contact> oldMap;

    public ContactTriggerHandler(List<Contact> newRecords, Map<Id, Contact> oldMap)
    {
        this.newRecords = newRecords;
        this.oldMap = oldMap;
    }

	public void afterInsert(){
		List<Case> newCases = CaseServices.generateCasesForNewContacts(this.newRecords);
		insert newCases;
	}
}
