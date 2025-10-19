Perfect — this is an excellent plan for a **cross-platform, structured, agent-friendly system-administration repository**.
Below is a full set of **instructions and file scaffolding** for an autonomous coding agent (such as OpenAI Codex, GitHub Copilot Workspace, or any CI bot) to populate your new repo called **`sys-admin`**.

---

## 🧭 1️⃣ Repository overview

**Repo name:** `sys-admin`
**Purpose:** General-purpose system administration toolkit, with a subsection for *boot rescue* and other platform-specific utilities.
**Structure enforcement:** fixed top-level directories →
`csv  .gitignore  fig  jnb  license.md  log  qmd  readme.md  res  src  tmp  web`

---

## 🧩 2️⃣ Directory-layout specification (for the coding agent)

```bash
# root structure
sys-admin/
│
├── .gitignore
├── csv/          # tabular data and configuration exports (CSV, TSV)
├── fig/          # static images, diagrams, screenshots
├── jnb/          # Jupyter or notebook files (.ipynb, .qmd with code cells)
├── license.md    # license information (MIT, CC-BY, etc.)
├── log/          # runtime or system logs
├── qmd/          # documentation, manuals, tables, figures (Quarto/Markdown)
│   ├── mac/
│   ├── nix/
│   └── win/
│
├── readme.md     # main entry point
├── res/          # resources, templates, static assets
├── src/          # executable or source files
│   ├── mac/
│   ├── nix/
│   └── win/
│
├── tmp/          # temporary or scratch output
└── web/          # publicly built or exported HTML (for GitHub Pages)
```

---

## 🧠 3️⃣ Agent instructions (Codex / Copilot task description)

```text
SYSTEM INSTRUCTION FOR CODING AGENT:

Goal:
Populate the GitHub repository "sys-admin" with the exact directory
structure and base files listed below.

Rules:
1. Top-level names must exactly match:
   csv  .gitignore  fig  jnb  license.md  log  qmd  readme.md  res  src  tmp  web
2. Documentation files (manuals, tables, text figures) go only in qmd/
   and must be subdivided into qmd/mac, qmd/nix, qmd/win.
3. Source or executable files go only in src/
   and must be subdivided into src/mac, src/nix, src/win.
4. Public HTML, CSS, or JS files live only in web/.
5. Use lowercase for all filenames and directories.

Actions:
- Create empty placeholder README files in each subdirectory.
- Generate a root readme.md describing repository purpose and structure.
- Add a license.md with an MIT license template.
- Add a .gitignore file suitable for a mixed shell/python/quarto project.
- In qmd/nix/, create a file "boot-recovery-handbook.qmd"
  containing the Boot Recovery documentation table and example script references.
- In src/nix/, add "grub-restore.sh" and ensure it has execute permissions.
- In web/, create "index.html" with a placeholder link to qmd/ documentation.
- Verify all directories exist before writing files.
```

---

## 🧱 4️⃣ Minimal seed content for the agent to write

### `.gitignore`

```gitignore
# Common ignores
*.swp
*.log
*.tmp
*.bak
__pycache__/
.ipynb_checkpoints/
.DS_Store
tmp/
web/.quarto/
web/_site/
```

### `license.md`

```markdown
MIT License

Copyright (c) 2025 Nils Holmberg

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction...
```

### `readme.md`

````markdown
# Sys-Admin Repository

General-purpose system administration toolkit.

## Structure
| Dir | Purpose |
|-----|----------|
| `qmd/` | Documentation and manuals (split by platform) |
| `src/` | Executable and source scripts |
| `web/` | Published HTML output |
| `csv/`, `fig/`, `jnb/`, `log/`, `res/`, `tmp/` | Support data and assets |

Boot-rescue utilities live under `qmd/nix/` and `src/nix/`.

## Quick start
Clone and explore:
```bash
git clone https://github.com/<user>/sys-admin.git
tree -L 2
````

````

### `qmd/nix/boot-recovery-handbook.qmd`
```markdown
---
title: "Boot Recovery Handbook"
format: html
---

## Overview
This Quarto document summarizes recovery strategies for UEFI + LUKS + LVM
dual-boot systems (Debian/Windows).

Include reference tables from `tables/boot-failure-categories.md`
and scripts from `src/nix/grub-restore.sh`.

To render:
```bash
quarto render qmd/nix/boot-recovery-handbook.qmd --to html
````

````

### `src/nix/grub-restore.sh`
```bash
#!/usr/bin/env bash
# Debian/Ubuntu GRUB EFI restore script
set -euo pipefail
EFI_PART="/dev/nvme0n1p1"
EFI_DIR="/boot/efi"
BOOT_ID="debian"
sudo grub-install --target=x86_64-efi --efi-directory="$EFI_DIR" \
  --bootloader-id="$BOOT_ID" --modules="part_gpt part_msdos cryptodisk luks lvm"
sudo update-grub
sudo efibootmgr -v | grep -E 'Boot|debian|Windows'
````

### `web/index.html`

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Sys-Admin Utilities</title>
</head>
<body>
  <h1>Sys-Admin Repository</h1>
  <p>See <a href="../qmd/nix/boot-recovery-handbook.qmd">Boot Recovery Handbook</a></p>
</body>
</html>
```

---

## ⚙️ 5️⃣ Git initialization and push commands

```bash
cd ~/dev
git init sys-admin
cd sys-admin
# (run the agent or create files as above)
git add .
git commit -m "Initial cross-platform sys-admin repository structure"
git remote add origin https://github.com/<user>/sys-admin.git
git branch -M main
git push -u origin main
```

---

## ✅ Result

Your GitHub repo will have this reproducible scaffold:

```
sys-admin/
├── .gitignore
├── csv/
├── fig/
├── jnb/
├── license.md
├── log/
├── qmd/
│   ├── mac/
│   ├── nix/
│   │   └── boot-recovery-handbook.qmd
│   └── win/
├── readme.md
├── res/
├── src/
│   ├── mac/
│   ├── nix/
│   │   └── grub-restore.sh
│   └── win/
├── tmp/
└── web/
    └── index.html
```

---

Would you like me to generate a **single shell script (`populate-sys-admin.sh`)** that performs all these steps automatically (creates directories, writes sample files, and commits them)?
