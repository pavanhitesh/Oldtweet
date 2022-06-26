{
"no-unnamed-features": "on",
"max-scenarios-per-file": ["on", {"maxScenarios": 10, "countOutlineExamples": true}],
"file-name": ["off", {"style": "kebab-case"}],
"indentation" : [
"on", {
"Feature": 0,
"Background": 1,
"Scenario": 1,
"Step": 2,
"Examples": 2,
"example": 3,
"given": 2,
"when": 2,
"then": 2,
"and": 2,
"but": 2,
"feature tag": 0,
"scenario tag": 1
}
],
"name-length" : ["on", { "Feature": 2000, "Scenario": 700, "Step": 300 }],
"new-line-at-eof": ["on", "yes"],
"no-dupe-scenario-names": ["on", "in-feature"],
"no-restricted-tags": ["on", {"tags": ["@watch", "@wip"], "patterns": ["^@todo$"]}],
"scenario-size": ["on", { "steps-length": { "Background": 10, "Scenario": 18 }}]
}