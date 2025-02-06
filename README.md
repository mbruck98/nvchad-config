# My NvChad configuration

## Installation

`git clone https://github.com/mbruck98/nvchad-config ~/.config/nvim`

Run nvim and after it finishes installing all the plugins, run:
```
  :MasonInstallAll 
  :MasonInstall cpptools
```
Exit nvim and run:
```
cd ~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/
cp cppdbg.ad7Engine.json nvim-dap.ad7Engine.json
cd ~/.config/nvim/
rm -rf .git
```


