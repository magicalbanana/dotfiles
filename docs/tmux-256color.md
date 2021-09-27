## The definitive guide to using tmux-256color on macOS

- https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos/
- https://github.com/tmux/tmux/issues/2262

TLDR;

Run this command:

```
/usr/local/opt/ncurses/bin/infocmp -x tmux-256color | sed -e 's/pairs#0x10000/pairs#0x1000/' -e 's/pairs#65536/pairs#32768/' > tmux-256color.src
/usr/bin/tic -x tmux-256color.src
```

The solution is to get the tmux-256color terminfo entry from the newer version
of ncurses into macOS’s terminfo database. First, create a copy of the current
tmux-256color terminfo entry from the version of curses installed by your
package manager:

```
# MacPorts
$ /opt/local/bin/infocmp -x tmux-256color > ~/tmux-256color.src

# Homebrew
$ /usr/local/opt/ncurses/bin/infocmp -x tmux-256color > ~/tmux-256color.src
```

Now, modify the tmux-256color.src file to change the pairs value from 65536 to
32768. This must be done because of a bug in ncurses 5.7 that interprets
pairs#65536 as pairs#01.


```
Before:

pairs#0x10000

or

pairs#65536

After:

pairs#0x1000

or

pairs#32768
```

If you are on a macOS version prior to Catalina, you can install this new
terminfo entry into the system database /usr/share/terminfo. This will ensure
that programs linked against the old version of ncurses will use this entry,
while programs installed by your package manager will continue to use the
entry from the newer version of ncurses. To do this, simply run

```
sudo /usr/bin/tic -x tmux-256color.src
```

Be sure to use /usr/bin/tic and not just tic: this will use the system version
of ncurses to compile the database entry, which is required for system
programs linked against that version of ncurses work properly.
