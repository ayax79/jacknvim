;; extends

; a `# sql` comment right above a let/mut/const
((comment) @_c
  .
  [
    (stmt_let   value: (pipeline (pipe_element (val_string (string_content) @injection.content))))
    (stmt_mut   value: (pipeline (pipe_element (val_string (string_content) @injection.content))))
    (stmt_const value: (pipeline (pipe_element (val_string (string_content) @injection.content))))
  ]
  (#match? @_c "^#\\s*sql")
  (#set! injection.language "sql"))

; any string whose content starts with a SQL keyword (case-insensitive)
((string_content) @injection.content
  (#match? @injection.content "\\c^\\_s*\\(select\\|with\\|insert\\|update\\|delete\\|create\\)\\>")
  (#set! injection.language "sql"))
