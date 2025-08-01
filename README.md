```
              __   ___    ____
  ____ ______/ /__/   |  /  _/
 / __ `/ ___/ //_/ /| |  / /
/ /_/ (__  ) ,< / ___ |_/ /
\__,_/____/_/|_/_/  |_/___/
```
ask-AI
======
Are you looking at your computer and telling to yourself: "If only there was
more AI in my computer." Well do I have a solution for you. **ask-AI** is a
simple cli utility that acts as a frontend to your local ollama instance
allowing you to interact with it directly from the command line.

## Usage
You can invoke it directly from the command line by typing:

```bash
ask-ai How do write a simple hello world application in Python
```
*no quoting needed👍*

> [!NOTE]
> If you are to use any special characters that are part of shell syntax you
> will need to quote them.

## Installation
To install ask-AI you just need to make sure that `ask-ai.sh` is somewhere on
`$PATH` and you're good to go. I'd however recommend to alias it to something
else like `@` in your `.bashrc`/`.zshrc` like:

```bash
alias @='ask-ai'
```

## Motivation
[Warp](https://www.warp.dev/) has a builtin AI that can assist you with doing
things in the terminal. And I thought it would be nice feature for both
beginners and more advanced users if it wasn't tied to a specific terminal
emulator. Of course this is nowhere near as complex as as what Warp provides
but it should cover good amount of usecases.
