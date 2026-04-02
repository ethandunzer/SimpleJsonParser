# SimpleJsonParser

## Overview
SimpleJsonParser is a reusable, bulk-safe Apex invocable action for Salesforce Flow. It parses flat JSON input and returns key/value results based on provided mappings, with robust error handling and Flow-friendly output.

## Usage in Flow
1. Add the **Simple Json Parser** invocable action to your Flow.
2. Pass the raw JSON string to the `jsonBody` input.
3. Pass a collection of mapping strings (e.g., `Name=name;Email=email;Role=role` split into a collection) to the `keyMappings` input.
4. The action returns a collection of JsonResult rows for each mapping.

### Example Input JSON
```
{
	"name": "Jane Smith",
	"email": "jane@test.com",
	"role": "Consultant"
}
```

### Example Key Mappings (as collection)
- Name=name
- Email=email
- Role=role

### Expected Output
| outputKey | value         | success | errorMessage |
|-----------|--------------|---------|--------------|
| Name      | Jane Smith   | true    | (blank)      |
| Email     | jane@test.com| true    | (blank)      |
| Role      | Consultant   | true    | (blank)      |

## Error Handling
- If `jsonBody` is missing or invalid, a result row with `success=false` and an error message is returned.
- If a mapping is malformed or a key is missing, a result row with `success=false` and an error message is returned for that mapping.
- The action is bulk-safe and returns results for each request independently.

## Output Structure (JsonResult)
- **outputKey**: Friendly key name for Flow usage
- **value**: Extracted value from the JSON
- **success**: Indicates whether the key was parsed successfully
- **errorMessage**: Populated when parsing fails

## Future Enhancements
- Support for nested JSON paths (e.g., `candidate.name`)
- Support for array indexing (e.g., `items[0].id`)
- Configurable delimiter
- Debug logging
# SimpleJsonParser

