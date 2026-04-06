trigger AccountAfterInsertNewChildContactLink on Account (after insert) {
    AccountHandler.createChildContactForNewAccount(Trigger.new);
}