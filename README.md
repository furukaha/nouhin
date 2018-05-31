# Nouhin

納品物管理コマンドライン・ツール(CLI) - アーカイブでソースの納品を求められる環境下で、納品対象物を管理するためのコマンド.

## Description
git でバージョン管理するほどの案件ではなかったり、git で顧客とつながるほどの案件でなかったり、アーカイブ納品で済んでしまう状況はよくあることです。
しかし「あれ？どれが修正したソースで、どれを納品すればいいんだっけ？ 抜け漏れが心配だなぁ」そんな状況もよくあることです。
そんなときにこれがあれば、納品対象のソース管理が簡単になります。
* git と似たような感じで使えます。
* add で管理対象ステージに追加して、reset でアンステージします。commit で納品対象物をアーカイブ化します。
* ローカル完結です。リモートも ssh-key の設定などもありません。
* バージョン管理はしていません。あくまで納品対象物の管理です。
くわしくは `nouhin help` を参照してください。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nouhin'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nouhin

## Usage
    $ nouhin -h
    nouhin commands:
      nouhin add FILE        # FILE を納品対象としてインデックスに登録します.
      nouhin commit FILE     # 納品対象のファイルをまとめたアーカイブ FILE を作成します.
      nouhin compress FILE   # 納品対象のファイルをまとめたアーカイブ FILE を作成します.
      nouhin expand FILE     # アーカイブ FILE を展開します.
      nouhin help [COMMAND]  # Describe available commands or one specific command
      nouhin init            # 納品対象を管理するインデックスファイル(~/nouhin_files.index)を初期化します.
      nouhin list            # 現在 納品対象として管理されているファイルを一覧で表示します.
      nouhin reset FILE      # FILE を納品対象から外します.
      nouhin status          # 現在 納品対象として管理されているファイルを一覧で表示します.
      nouhin test FILE       # アーカイブ FILE の中身を一覧で表示します.

