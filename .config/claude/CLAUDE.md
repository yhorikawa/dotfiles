# Claude Code Configuration

## 出力設定

日本語で応答してください。
コードのコメントなどは元の言語のままにしてください。

全角記号より半角記号を優先して使ってください。
特に全角括弧は禁止。

## 利用するコマンド

### 非推奨

* `cat`: 代わりにあなた自身がファイルを読み込んでください。

### 禁止

* `rm`: 代わりに`trash`を使ってください。

## タスクの終了時

* タスクが終わったら以下のコマンドでコストを表示してください：
  * 現在のセッションコスト: `bunx ccusage@latest session --json | jq -r '.sessions[] | select(.sessionId == "-workspaces-api-mock-server") | .totalCost'`
  * 今日の合計コスト: `bunx ccusage@latest --json | jq --arg d "$(date +%F)" '.daily[] | select(.date == $d)'`
