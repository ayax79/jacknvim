; extends

; Shell-script injections for Nix files (nushell, zsh, bash).
; Strings are injected when the enclosing attribute is e.g. `programs.zsh = { ... }`,
; or when the option key is a well-known shell-script option.

; programs.nushell = { <option> = ''...''; };
(binding
  attrpath: (attrpath (identifier) @_shell .)
  expression: (attrset_expression
    (binding_set
      (binding
        expression: (indented_string_expression
          (string_fragment) @injection.content))))
  (#eq? @_shell "nushell")
  (#set! injection.language "nu")
  (#set! injection.combined))

; programs.nushell.<option> = ''...'';
(binding
  attrpath: (attrpath (identifier) @_shell . (identifier) .)
  expression: (indented_string_expression
    (string_fragment) @injection.content)
  (#eq? @_shell "nushell")
  (#set! injection.language "nu")
  (#set! injection.combined))

; programs.zsh = { <option> = ''...''; };
(binding
  attrpath: (attrpath (identifier) @_shell .)
  expression: (attrset_expression
    (binding_set
      (binding
        expression: (indented_string_expression
          (string_fragment) @injection.content))))
  (#eq? @_shell "zsh")
  (#set! injection.language "zsh")
  (#set! injection.combined))

; programs.zsh.<option> = ''...'';
(binding
  attrpath: (attrpath (identifier) @_shell . (identifier) .)
  expression: (indented_string_expression
    (string_fragment) @injection.content)
  (#eq? @_shell "zsh")
  (#set! injection.language "zsh")
  (#set! injection.combined))

; programs.bash = { <option> = ''...''; };
(binding
  attrpath: (attrpath (identifier) @_shell .)
  expression: (attrset_expression
    (binding_set
      (binding
        expression: (indented_string_expression
          (string_fragment) @injection.content))))
  (#eq? @_shell "bash")
  (#set! injection.language "bash")
  (#set! injection.combined))

; programs.bash.<option> = ''...'';
(binding
  attrpath: (attrpath (identifier) @_shell . (identifier) .)
  expression: (indented_string_expression
    (string_fragment) @injection.content)
  (#eq? @_shell "bash")
  (#set! injection.language "bash")
  (#set! injection.combined))

; Nix builders: pkgs.writeShellScript "name" ''...'', writeShellScriptBin, writeBash, ...
(apply_expression
  function: (_) @_func
  argument: (indented_string_expression
    (string_fragment) @injection.content)
  (#lua-match? @_func "write[%w]*Sh[%w]*$")
  (#set! injection.language "bash")
  (#set! injection.combined))

(apply_expression
  function: (_) @_func
  argument: (indented_string_expression
    (string_fragment) @injection.content)
  (#lua-match? @_func "writeBash[%w]*$")
  (#set! injection.language "bash")
  (#set! injection.combined))

(apply_expression
  function: (_) @_func
  argument: (indented_string_expression
    (string_fragment) @injection.content)
  (#lua-match? @_func "writeZsh[%w]*$")
  (#set! injection.language "zsh")
  (#set! injection.combined))

(apply_expression
  function: (_) @_func
  argument: (indented_string_expression
    (string_fragment) @injection.content)
  (#lua-match? @_func "writeNu[%w]*$")
  (#set! injection.language "nu")
  (#set! injection.combined))

; writeShellApplication { text = ''...''; }
(apply_expression
  function: (_) @_func
  argument: (attrset_expression
    (binding_set
      (binding
        attrpath: (attrpath (identifier) @_attr)
        expression: (indented_string_expression
          (string_fragment) @injection.content))))
  (#lua-match? @_func "writeShellApplication$")
  (#eq? @_attr "text")
  (#set! injection.language "bash")
  (#set! injection.combined))
