---
title: Vscode<=Sync=>Github
date: 2020-03-02 12:05:00 +0800
categories: [Learning, Self-study]
tags: [Vscode, GitHub, Sync]
toc: true
seo:
  date_modified: 2020-03-02 17:48:52 +0800
---

## Creat Your Personal Token
---


1. Open this website [Github-Settings-Developer settings](https://github.com/settings/tokens).
2. Click the `Generate new token` button.
3. Fill you preferred name within the `Note` block(e.g., sync-vscode). Select those rights that you would like to offer.(e.g., `repo`, `gist`, etc). And then generate your token! 
4. Copy your token.


## Creat Your Gist Id
---


1. Open this website [GitHub-Gist](https://gist.github.com/).
2. Create your own [gist](https://en.wikipedia.org/wiki/Gist "wikipedia")
3. Copy your gist's url(gist id).
   

## Open Your VsCode
---

1. Install Settings-sync by Extensions(vscode)(After we have store tokens and gist id)
2. Hold down `Ctrl + Shift + P`  simultaneously,  to call out the searching bar, and input `Sync`.
3. Choose the selection: `Sync:Advanced Options`, then, `Sync:edit local Extension sets.
4. Fill in the token and the gist id.
```
"token": "fill your token",              //fill your token here
    "downloadPublicGist": false,
    "supportedFileExtensions": [
        "json",
        "code-snippets"
    ],
    "openTokenLink": true,
    "fill your gist id": "sync",            //fill your gist id here
```


## How To Use Shortcuts
---

* Upload : `Shift + Alt + U` for Windows, `Shift + Option + U` for MaxOs.
* Download : `Shift + Alt + D` for Windows, `Shift + Option + D` for MaxOs.


