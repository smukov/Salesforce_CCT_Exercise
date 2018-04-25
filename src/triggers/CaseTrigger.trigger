trigger CaseTrigger on Case (
    before insert,
    before update,
    before delete,
    after insert,
    after update,
    after delete,
    after undelete) {

        CaseTriggerHandler handle = new CaseTriggerHandler(trigger.new, trigger.oldMap);
        if (trigger.isAfter)
        {
            if (trigger.isInsert) handle.afterInsert();
        }
}
