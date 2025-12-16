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
                "!And",
                "!Base64",
                "!Cidr",
                "!Equals",
                "!FindInp sequence",
                "!GetAZs",
                "!GetAtt",
                "!If",
                "!ImportValue",
                "!Join sequence",
                "!Not",
                "!Or",
                "!Ref Scalar",
                "!Ref",
                "!Select",
                "!Split",
                "!Sub",
                "!fn",
                -- gitlab ci
                "!reference sequence",
            },
        },
    },
}
