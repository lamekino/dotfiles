![Screenshot](./screenshot.png?raw=true)

Dotfiles
--------

These are my configs for my computers. To use `install.sh`, install `stow`.
It will symlink the dotfiles for the current user.

#### 📁 `user/`

  Contains the main dotfiles. Each subdirectory will be installed to $HOME with
  `stow`.

#### 📁 `windows/`

  Files for MS Windows. Whenever I use it again I'll write a powershell script
  to install them + the configs from `user/` which I use on Windows.

### Installing

```sh
$ git clone https://github.com/lamekino/dotfiles
$ cd dotfiles
$ ./install.sh
```

### Uninstalling

```sh
$ ./install.sh -x
```
