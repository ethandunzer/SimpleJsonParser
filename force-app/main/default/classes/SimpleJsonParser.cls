public with sharing class SimpleJsonParser {
    /**
     * Invocable method for Salesforce Flow: Simple Json Parser
     * Parses JSON input and returns key-value results based on provided mappings.
     */
    @InvocableMethod(
        label='Simple Json Parser'
        description='Parses JSON input and returns key-value results based on provided mappings.'
    )
    public static List<List<JsonResult>> parseJson(List<FlowRequest> requests) {
        List<List<JsonResult>> allResults = new List<List<JsonResult>>();
        for (FlowRequest req : requests) {
            List<JsonResult> results = new List<JsonResult>();

            // Validate input
            if (String.isBlank(req.jsonBody)) {
                results.add(new JsonResult(
                    null, null, false, 'Missing jsonBody input.'
                ));
                allResults.add(results);
                continue;
            }
            if (req.keyMappings == null || req.keyMappings.isEmpty()) {
                results.add(new JsonResult(
                    null, null, false, 'Missing keyMappings input.'
                ));
                allResults.add(results);
                continue;
            }

            Map<String, Object> jsonMap;
            try {
                Object parsed = JSON.deserializeUntyped(req.jsonBody);
                jsonMap = (Map<String, Object>)parsed;
            } catch (Exception e) {
                results.add(new JsonResult(
                    null, null, false, 'Invalid JSON: ' + e.getMessage()
                ));
                allResults.add(results);
                continue;
            }

            for (String mapping : req.keyMappings) {
                if (String.isBlank(mapping)) {
                    results.add(new JsonResult(null, null, false, 'Empty mapping string.'));
                    continue;
                }
                Integer eqIdx = mapping.indexOf('=');
                if (eqIdx <= 0 || eqIdx == mapping.length() - 1) {
                    results.add(new JsonResult(
                        null, null, false, 'Malformed mapping: ' + mapping
                    ));
                    continue;
                }
                String outputKey = mapping.substring(0, eqIdx).trim();
                String jsonKey = mapping.substring(eqIdx + 1).trim();
                if (String.isBlank(outputKey) || String.isBlank(jsonKey)) {
                    results.add(new JsonResult(
                        outputKey, null, false, 'Malformed mapping: ' + mapping
                    ));
                    continue;
                }
                if (!jsonMap.containsKey(jsonKey)) {
                    results.add(new JsonResult(
                        outputKey, null, false, 'Missing JSON key: ' + jsonKey
                    ));
                    continue;
                }
                Object val = jsonMap.get(jsonKey);
                String valStr = val == null ? null : String.valueOf(val);
                results.add(new JsonResult(
                    outputKey, valStr, true, null
                ));
            }
            allResults.add(results);
        }
        return allResults;
    }

    /**
     * Helper class for Flow input
     */
    public class FlowRequest {
        @InvocableVariable(label='JSON Body' description='Raw JSON string to parse')
        public String jsonBody;

        @InvocableVariable(label='Key Mappings' description='Collection of key mapping strings (outputKey=jsonKey)')
        public List<String> keyMappings;
    }
}