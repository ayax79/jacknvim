;; extends

; Option A: any string that starts with a SQL keyword
((val_string) @injection.content
  (#match? @injection.content "^[\"'`]\\s*(SELECT|select|WITH|with|INSERT|insert|UPDATE|update|DELETE|delete|CREATE|create)")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "sql"))

; Option B: strings marked with a `# sql` comment on the line above
((comment) @_c
  .
  (_ (val_string) @injection.content)
  (#match? @_c "^#\\s*sql")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "sql"))

