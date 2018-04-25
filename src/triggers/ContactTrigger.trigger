trigger ContactTrigger on Contact (
	before insert,
	before update,
	before delete,
	after insert,
	after update,
	after delete,
	after undelete) {

		ContactTriggerHandler handle = new ContactTriggerHandler(trigger.new, trigger.oldMap);
        if (trigger.isAfter)
        {
            if (trigger.isInsert) handle.afterInsert();
        }
}
