# Goss notes

## Gotchas

- Only use underscore '_' in variables hypen '-' and dot '.' will cause issues

- When using command you need to escape any colon':' in the line or it will error

- Read the error it may mention the line or what the problem is (not always) (newer version appears better)

- when running goss use goss file option (-g) if not specified it will only default to ./goss.yaml (not goss.yml)

## Variables

These are loaded within the vars file using the command

```sh
goss -g {{ goss file }} --vars vars.cis.yml
```

- written in a key:value format

e.g.

```sh
ubuntu20cis_rule_1_1_1: true
passwd_age: "10"   #Int wrapped in quotes
users:
- bob
- alison
- fred
```

### pass a variable

The are references using the .Vars option.

These are surrounded by curly brace.

```sh
{{ .Vars.some_variable_here }}
```

## Adding logic to a variable

- Place the test between if and close if statements

### Boolean value

```yml
{{ if .Vars.ubuntu20cis_rule_1_1_1 }}
put you're test in between
the 
start and stop statements
{{ end }}
```

### Using a list

```yml
{{ range .Vars.list_variables }}
stdout: {{ . }}
{{ end }}
```

### Matching a variable

```yml
{{ if eq .Vars.some_value 'OK' }}

{{ end }}
```

### Multiple tests

e.g.

```yml
{{ if (( eq .Vars.somevalue 'OK' ) and .Vars.ubuntu20cis_rule_1_1_1 ) }}
goss requirements
placed in 
here
{{ end }}
```

## Using regex

Surround the string and regex with '/'
e.g.
A number between 1 and 9

```yml
['/[1-9]/']
```

not between 1 and 9

```sh
['!/[1-9]/']
```

Expect an empty response from command

```sh
['!/./']
```

### Using variables inside variables (nested)

e.g.

```yml
{{ if .Vars.ubuntu20cis_rule_1_1_1 }}
file:
  /etc/users:
    exists: true
    contains:
    {{ range .Vars.users }}
    stdout:
    - {{ . }}
    {{ end }}
{{ end }}
```
