# Site search 用のスクリプト

## CopyPageTitleWithURL

たまにちゃんと動かない。

```js
javascript: (() => { const text = `[${document.title}](${location.href})`; const userInput = prompt('markdown リンクとしてコピー', text); if (userInput !== null) { const textarea = document.createElement('textarea'); textarea.value = userInput; document.body.appendChild(textarea); textarea.select(); document.execCommand('copy'); document.body.removeChild(textarea); } })();
```

## GitHub Search

```
https://github.com/search?q=%s&type=Code&utf8=✓
```

## X Search

```
https://x.com/search?q=%s
```

## Perplexity

```
https://www.perplexity.ai?q=%s
```
