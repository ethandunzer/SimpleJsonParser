public with sharing class JsonResult {
    @AuraEnabled
    @InvocableVariable(label='Output Key' description='Friendly key name for Flow usage')
    public String outputKey;

    @AuraEnabled
    @InvocableVariable(label='Value' description='Extracted value from the JSON')
    public String value;

    @AuraEnabled
    @InvocableVariable(label='Success' description='Indicates whether the key was parsed successfully')
    public Boolean success;

    @AuraEnabled
    @InvocableVariable(label='Error Message' description='Populated when parsing fails')
    public String errorMessage;

    public JsonResult() {}

    public JsonResult(String outputKey, String value, Boolean success, String errorMessage) {
        this.outputKey = outputKey;
        this.value = value;
        this.success = success;
        this.errorMessage = errorMessage;
    }
}