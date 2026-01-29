return {
    settings = {
        yaml = {
            hover = true,
            completion = true,
            schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
            },
            schemas = require('schemastore').yaml.schemas({
                select = {
                    "AWS CloudFormation",
                    "AWS CloudFormation Serverless Application Model (SAM)",
                    "AWS SAM CLI Samconfig",
                },
            }),
            customTags = {
                -- SA/ Cloudformation
                "!And sequence",
                "!Base64 scalar",
                "!Cidr sequence",
                "!Condition scalar",
                "!Equals sequence",
                "!FindInMap sequence",
                "!GetAtt",
                "!GetAZs",
                "!If sequence",
                "!ImportValue",
                "!Join sequence",
                "!Not sequence",
                "!Or sequence",
                "!Ref",
                "!Select sequence",
                "!Split sequence",
                "!Sub",

                -- gitlab ci
                "!reference sequence",
            },
        },
    },
}
