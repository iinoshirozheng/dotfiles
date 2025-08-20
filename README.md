# Dotfiles

這是我的 dotfiles 專案，用於管理和同步我的開發環境設定。

## 結構

- `bootstrap.sh`：第一次安裝入口，偵測 OS 並安裝必要工具。
- `install.sh`：共用安裝腳本，安裝字型和常用工具。
- `uninstall.sh`：移除所有設定。
- `bin/`：個人腳本，包含更新工具。
- `stow/`：使用 GNU Stow 管理的設定檔。
- `os/`：針對不同作業系統的覆寫設定。
- `host/`：針對不同機器的覆寫設定。
- `secrets/`：機密檔案，不會加入版本控制。
- `test/`：測試腳本。

## 使用方式

1. 執行 `bootstrap.sh` 進行初始化。
2. 使用 `install.sh` 安裝必要工具和設定。
3. 若需更新，執行 `bin/update.sh`。

## 授權

本專案採用 MIT 授權，詳見 [LICENSE](./LICENSE)。
