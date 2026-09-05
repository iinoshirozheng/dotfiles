# Dotfiles

這是我的個人化開發環境配置專案，主要針對 macOS 進行優化，但也可在 Linux 上運行。
使用 **GNU Stow** 進行設定檔管理，並提供統一的 **CLI 工具** 來自動化所有操作。

## ✨ 特色

*   **自動化安裝**: 一鍵安裝所有工具、字型與設定。
*   **強大的 CLI**: 內建 `dotfile` 指令，統一管理安裝、更新與連結。
*   **現代化 Shell**:
    *   **Zsh** + **Oh My Zsh** + **Starship**: 極速且美觀的 Prompt。
    *   **FZF** + **Fd**: 極速模糊搜尋 (Respect .gitignore)。
    *   **Zoxide**: 智慧目錄跳轉 (`z`).
    *   **Bat**: 帶有語法高亮的 Man pages。
*   **Neovim IDE**:
    *   基於 **Lazy.nvim** 的現代化配置。
    *   **Catppuccin** 主題。
    *   **LSP** (Mason, CMP) 支援多語言自動補全。
    *   **Telescope** & **Neo-tree**。
*   **Git 優化**: 整合 **Delta** 讓 diff 變得美觀易讀，並預設常用 Alias (`st`, `lg`, `co`...)。
*   **套件管理**: 整合 **Homebrew**, **Pixi**, **Uv**。
*   **AI Agent skills**: `agent/skills/` 收納並持續擴充可安裝的開發技能。

## 📂 結構

- `bin/dotfile`: **核心管理腳本** (CLI)。
- `bootstrap.sh`: 首次安裝入口。
- `Brewfile`: macOS 套件清單 (包含 Cask & Fonts)。
- `stow/`: 設定檔來源 (Zsh, Git, Neovim, Starship...)。
- `os/`: OS 專屬設定腳本。
- `agent/skills/`: AI Agent skills 與其參考資料。

## 🚀 快速開始

### 首次安裝

```bash
git clone https://github.com/iinoshirozheng/dotfiles.git ~/dotfiles
cd ~/dotfiles
make
# 或者手動執行: ./bootstrap.sh
```

### 日常使用 (`dotfile` CLI)

安裝完成後，您可以使用 `dotfile` 指令 (或 `make` 快捷鍵) 來管理環境：

| 指令 | 說明 |
| :--- | :--- |
| `dotfile install` | 安裝所有工具、字型並連結設定 (自動偵測 OS) |
| `dotfile link` | 重新連結設定檔 (使用 Stow) |
| `dotfile update` | 安全更新專案 (Git Pull + Re-stow) |
| `dotfile test` | 執行測試 |
| `skills install` | 安裝並連結新的 AI Agent 技能 |

### Neovim

首次啟動 `nvim` 時，**Lazy.nvim** 會自動下載並安裝所有外掛。

```bash
nvim
```

## ⌨️ 常用快捷鍵 (Alias)

- `update`: Reload zshrc
- `dot`: `cd ~/dotfiles`
- `brewup`: Update & Upgrade Homebrew
- `g`: `git` (如果沒有外掛)
- `ga`, `gc`, `gp`, `gl`: Git 常用操作
- `vi`, `vim` -> `nvim`

### Ripgrep (增強顏色搜尋)

| Alias | 說明 |
| :--- | :--- |
| `rgg` | 增強版搜尋 (支援 pipeline) |
| `rgf` | 搜尋檔名 |
| `rgi` | 不區分大小寫 |
| `rgh` | 包含隱藏檔案 |
| `rga` | 搜尋所有檔案 (含 gitignore) |
| `rgt` | 搜尋指定類型 (e.g. `rgt py "pattern"`) |
| `rgtls` | 列出所有支援類型 |
| `rgc` | 顯示上下文 3 行 |
| `rge` | 搜尋指定副檔名 (e.g. `rge "*.tsx" "pattern"`) |

## 授權

MIT License
