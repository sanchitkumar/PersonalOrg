trigger EmailMessage_Before on EmailMessage (before insert) {
/* Before Insert */

    if (Trigger.isInsert && Trigger.isBefore) {

        EmailMessageHandler.onBeforeInsert(Trigger.new);

    }
}