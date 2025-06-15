#!/bin/bash
set -e

mkdir -p dist

# index.html を生成
cat <<EOF > dist/index.html
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8" />
  <title>Slide Index</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", sans-serif;
      background: #f9f9f9;
      margin: 0;
      padding: 2rem;
    }
    h1 {
      text-align: center;
      margin-bottom: 2rem;
    }
    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 1.5rem;
    }
    .card {
      background: white;
      padding: 1.2rem;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      text-decoration: none;
      color: inherit;
    }
    .card:hover {
      transform: translateY(-3px);
      box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
    }
    .card-title {
      font-size: 1.2rem;
      font-weight: bold;
      margin: 0 0 0.5rem 0;
    }
    .card-desc {
      font-size: 0.9rem;
      color: #555;
    }
    .card-date {
      font-size: 0.8rem;
      color: #888;
      margin-top: 0.8rem;
    }
  </style>
</head>
<body>
  <h1>📚 スライド一覧</h1>
  <div class="grid">
EOF

for dir in dist/*/; do
  name=$(basename "$dir")

  # デフォルト値
  desc="(説明なし)"
  date="(日付なし)"

  # 対応する元ファイル（存在すれば）
  md_path="project/src/slides/$name/content.md"
  if [ -f "$md_path" ]; then
    desc_line=$(grep -m 1 '^title:' "$md_path" || true)
    date_line=$(git log -1 --format="%ad" --date=short -- "$md_path" || true)

    # title: の値だけ取り出す
    desc=$(echo "$desc_line" | sed -E 's/^title:\s*//')
    date="$date_line"
  fi

  echo "    <a class=\"card\" href=\"./$name/\">" >> dist/index.html
  echo "      <div class=\"card-title\">$name</div>" >> dist/index.html
  echo "      <div class=\"card-desc\">$desc</div>" >> dist/index.html
  echo "      <div class=\"card-date\">📅 $date</div>" >> dist/index.html
  echo "    </a>" >> dist/index.html
done

cat <<EOF >> dist/index.html
  </div>
</body>
</html>
EOF

echo "✅ Slide index generated"
