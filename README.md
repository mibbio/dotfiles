##dotfiles
**config files for (arch)linux**

* parts of config based on [helmuthdu/dotfiles](https://github.com/helmuthdu/dotfiles)

***

**usage**
* files are prepared for this [dotfiles management tool](https://github.com/jbernard/dotfiles)
* clone repo to any directory you want
* copy `dotfilesrc.sample` to `~/.dotfilesrc`
* modify path for `repository` in `~/dotfilesrc` to base path of local repo
* run `dotfiles -s [-f]` in users home to sync files (-f overwrites exisiting files)

***

**some bash aliases/function need extra applications**

|alias/function|application|
|:-------------|:----------|
|```irc```|```screen``` ```irssi```|
|```colortable```|```xfce4-terminal```|
|```diff```|```colordiff```|
|```yt``` ```yp``` ```yta``` ```ypa```|```youtube-dl```|
|```gitlog```|```git```|
|```sysup``` *(archlinux only)*|*```yaourt``` (optional)*|

***

**&copy; mibbio** - 'do whatever you want' license
