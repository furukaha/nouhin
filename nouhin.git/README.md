# Nouhin

納品物管理コマンドライン・ツール(CLI) - アーカイブでソースの納品を求められる環境下で、納品対象物を管理するためのコマンド.

## Description
git でバージョン管理するほどの案件ではなかったり、git で顧客とつながるほどの案件でなかったり、アーカイブ納品で済んでしまう状況はよくあることです。

しかし Rails では、あちらこちらのコードに手を入れる必要があります。「あれ？どれが修正したソースで、どれを納品すればいいんだっけ？ 納品するときの抜け漏れが心配だなぁ」そんな状況もよくあることです。

そんなときにこれがあれば、納品対象のソース管理が簡単になります。

* git と似たような感じで使えますが、git よりシンプルです。
* add で納品対象ステージに追加して、reset でアンステージします。commit で納品対象物をアーカイブ化(tar.gz)します。
* ローカル完結です。なので、リモートも ssh-key の設定なども必要ありません。
* バージョン管理はしていません。あくまで納品対象物の管理です。


詳しい使い方は `nouhin help` を参照してください。

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

* ユーザーホームディレクトリ(~/)に、納品対象インデックス [ ~/nouhin_files.index ] が作られます。
* 作成/修正したファイルを `nouhin add FILE` で納品対象としてマークします。
* 間違ってマークした場合は `nouhin reset FILE` で納品対象から外します。
* テストが完了して納品する段階になったら `nouhin commit FILE` で納品用アーカイブファイルを作ります。
* commit は Rails プロジェクトのルートで実行するとよいでしょう。
* 作成したアーカイブファイルを納品して終了です。
* 新しく納品対象を管理する場合は `nouhin init` で納品対象インデックスを初期化します。

## Features
* simple is beautiful.
* バージョンという概念はありません。差分(diff)という概念もありません。
* リポジトリだとかリモートという概念もありません。
* もちろん、ssh 秘密鍵だとかユーザー登録という概念もありません。
* あるのは、それが「納品対象」かどうか、だけです。
* ソースコードに「納品予定」という付箋を貼っておくイメージです。(add)
* 提出するときに、それらをひとまとめにして段ボールに放り込むイメージです。(commit)
* もう一度言います。simple is beautiful.
* tar のオプション( -zcvf -zxvf -ztvf )を毎回調べていませんか？ 
* これからは `nouhin compress` `nouhin expand` `nouhin test` だけで済みます。

## FAQ
Q.`nouhin add FILE`したあとに、そのファイル名を変更しました。どうしたらいいですか？

A.`nouhin reset OLDFILE`するか`~/nouhin_files.index`をエディタで開き該当行を削除してください。その後`nouhin add NEWFILE`してください。



Q.`nouhin add FILE`は、ソースを修正する前にしたほうがいいですか？ 修正した後のほうがいいですか？

A.どちらでも構いません。それが「納品対象」かどうかだけを考えてください。ソースコードに「納品予定」という付箋を貼っておくイメージです。



## Requirement
command `tar`

## TODO
* `nouhin push` でリモートサーバーに SCP で送る機能必要？ もしくはメール送信？
* `nouhin pull` でリモートサーバーからアーカイブを引っ張ってくる？ 素直に Git を使えばいいじゃない。
