public with sharing class CaseServices {

	/**
	 * Generate Cases related to new Contacts
	 */
	public static List<Case> generateCasesForNewContacts(List<Contact> contacts){
		List<Case> newCases = new List<Case>();

		for(Contact contact : contacts){
			newCases.add(new Case(
				ContactId = contact.Id,
				AccountId = contact.AccountId,
				Origin = 'New Contact',
				Status = 'Working',
				OwnerId = contact.OwnerId,
				Priority = CaseServices.getCasePriority(contact)
			));
		}

		return newCases;
	}

	/**
	 * Get Case Priority based on provided Contact
	 */
	public static String getCasePriority(Contact c){

		if(c.Level__c == 'Primary'){ return 'High'; }
		if(c.Level__c == 'Secondary') { return 'Medium'; }
		if(c.Level__c == 'Tertiary') { return 'Low'; }

		return null;
	}
}
