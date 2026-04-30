trigger LeadDataNormalizationBeforeInsertUpdate on Lead (before insert, before update) {
    LeadHandler.leadDataNormalization(Trigger.new);
}