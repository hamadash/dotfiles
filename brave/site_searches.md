# Site search 用のスクリプト

## CopyPageTitleWithURL

```js
javascript: (() => { const text = `[${document.title}](${location.href})`; const userInput = prompt('markdown リンクとしてコピー', text); if (userInput !== null) { const textarea = document.createElement('textarea'); textarea.value = userInput; document.body.appendChild(textarea); textarea.select(); document.execCommand('copy'); document.body.removeChild(textarea); } })();
```
