# format.fish

Format text without all the `(set_color --bold yellow) ... (set_color --reset)`.

## Install

via [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish):

```fish
omf install format.fish

```

via [fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install aidenlangley/format.fish
```

## Usage

```fish
format -c red ... Print red text.
format -d/--dim brwhite ... Print dim white text.
format -i/--italic ... Print italic text.
format -o/--bold cyan ... Print bold cyan text.
format -u/--underline red ... Print underlined red text.
format -b/--background white -f/--foreground black ... Print black text on white background.
format -oi ... Print bold, dim text.
```
