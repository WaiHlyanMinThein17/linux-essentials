# 📓 Topic 2.1 Lesson 2 — Variables

**Course:** LPI Linux Essentials (010-160) · **Date:** May 7, 2026 · **Status:** ✅ Complete

## 📦 Types of Variables

| Type                 | Scope                            | Inherited by subprocesses? |
|----------------------|----------------------------------|----------------------------|
| Local variable       | Current shell only               | ❌ No                      |
| Environment variable | Current shell + all subprocesses | ✅ Yes                     |

- Variables are **not persistent** — lost when shell closes
- To make permanent → add to `~/.bashrc` or `~/.bash_profile`
- Most environment variables are in UPPERCASE (e.g. PATH, USER, HOME)

## 🔧 Working with Local Variables

```bash
greeting=hello           # create local variable (NO spaces around =)
echo $greeting           # print value → hello
echo greeting            # prints the word "greeting" (no $)
bash -c 'echo $greeting' # prints nothing — subprocess can't see local var
```

## 🌍 Working with Environment Variables

```bash
export greeting=hello            # create + export in one step
export greeting                  # export existing local variable
bash -c 'echo $greeting'         # now prints hello — subprocess can see it
env                              # display ALL environment variables
```

## 🗑️ Removing Variables

```bash
unset greeting    # correct — pass variable NAME (no $)
unset $greeting   # WRONG — passes the VALUE not the name
```

- Never use `$` with `unset` or `export` — pass the name, not the value

## 🛣️ The PATH Variable

- Most important environment variable in Linux
- Colon-separated list of directories where Bash searches for executables
- Order matters — first match found is executed

```bash
echo $PATH                    # view current PATH
which nano                    # find where nano executable is stored
PATH=$PATH:/home/wai/bin      # append new directory to PATH
PATH=$PATH:$mybin             # append using another variable
```

## ⚠️ PATH Warning

- Never do `PATH=/some/dir` alone — this REPLACES the entire PATH
- Always preserve existing PATH: `PATH=$PATH:/new/dir`
- Removing the wrong directory from PATH breaks commands

## 🌐 Using Variables with Commands

```bash
TZ=EST date    # run date command with a specific timezone
TZ=GMT date    # variables can be set inline before a command
```

## 📋 Commands Summary

| Command            | Purpose                                        |
|--------------------|------------------------------------------------|
| `var=value`        | Create local variable (no spaces around =)     |
| `export var=value` | Create environment variable                    |
| `export var`       | Convert local variable to environment variable |
| `echo $var`        | Print variable value                           |
| `unset var`        | Remove a variable (no $ sign)                  |
| `env`              | Display all environment variables              |
| `which command`    | Find path of an external command               |
| `echo $PATH`       | View current PATH                              |

## 🔑 Key Takeaways

- Local variables = current shell only; environment variables = subprocesses too
- NO spaces around = when creating variables
- Use `export` to make variables available to subprocesses
- Use `unset` to remove variables — no $ sign
- PATH is colon-separated — always append with `$PATH:/new/dir`
- Variables are not persistent — add to `~/.bashrc` to make permanent
- `which` finds external command paths; `env` shows all environment variables