## dotfiles
1: dotfilesをcloneする  
`git@github.com:13imi/dotfiles.git`

### .zsh
1: `dotfiles/`からホームへシンボリックリンクを張る
```
ln -sf .zshrc ~./.zshrc
ln -sf .zshenv ~./.zshenv
ln -sf ./.zprofile ~./.zpfofiles
```

2: `.zshrc`を読み混んで終了

### (Add) iTerm2 Preferences
新規デスクトップを開かないようにする
`General > Window > Native full screen windows > OFF`

新しいウィンドウの設定をフルスクリーンにする
`Profiles > Window > Settings for New Windows > Style, Screen, Space`

- Style: Fullscreen
- Screnn: Screen  with Cursor
- Space: All Spaces

HotKeyを設定する
`Keys > HotKey > Show/hide iTerm2 with a system-wide hotkey > ON`

テーマを設定する
`iceberg.itermcolors`を読み込み



