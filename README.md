# 🖼️ Marp Slide Decks

このリポジトリは、[Marp](https://marp.app/) で作成したスライドを GitHub Pages で公開しています。
スライドの追加・更新は Markdown を編集するだけで、自動でビルド & デプロイされ、スライド一覧ページにも反映されます。

---

## 📁 ディレクトリ構成

```
project/
└── src/
    ├── slides/
    │   └── sample/ デプロイ時のパス名。1スライドごとにこの階層が増える
    │       ├── content.md # スライド本文 (Markdown) は必ずcontent.mdという名称で作成すること
    │       └── images/ # スライド内で使用する画像フォルダ
    ├── themes/
    │   └── blue-theme.css # Marp用のカスタムテーマ
    └── scripts/
        └── generate-index.sh # スライド一覧画面 HTML 生成スクリプト
```

## 🧑‍💻 スライドの作成方法

### 1. 新しいスライドを作る

```bash
mkdir -p project/src/slides/my-new-slide/image
touch project/src/slides/my-new-slide/content.md
```

```markdown

---
marp: true
theme: blue-theme
class: lead
paginate: true
title: サンプルスライド <!-- この値はレイアウト一覧に表示されます -->
date: 2024-06-16 <!-- この値はレイアウト一覧に表示されます -->
---

# タイトルスライド

こんにちは！

---

## 画像表示の例
![bg right:40%](./images/hoge.png)
```

Marp syntax の詳細は 公式ドキュメント を参照してください。

## 🚀 自動化内容（GitHub Actions）
main ブランチに `project/src/slides/**/content.md` の変更があると、自動で以下を実行します：
| ステップ | 内容 |
| --- | --- |
|✅ ビルド | Marp CLI により .md → `dist/<slide>/index.html` を生成 |
|✅ 画像コピー | image/ フォルダ内の画像を `dist/<slide>/images/` にコピー |
|✅ スライド一覧生成 | `dist/index.html` をテンプレートから動的に生成 |
|✅ デプロイ | `dist/` フォルダを GitHub Pages に公開 |


## 🌐 スライド公開URL
スライドは GitHub Pages に自動デプロイされます。

- 一覧ページ: `https://<your-user>.github.io/<repo>/`  
- 各スライド: `https://<your-user>.github.io/<repo>/<slide-name>/`

新しいスライドを追加・更新したら main に push するだけでOK