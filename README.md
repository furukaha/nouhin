# Nouhin

納品物管理コマンドライン・ツール(CLI) - アーカイブでの納品を求められる環境下で、納品対象物を管理するためのコマンド.

## Description

git でバージョン管理するほどの案件ではなかったり、リモートで顧客とつながるほどの案件でなかったり、アーカイブ納品で済んでしまう状況はよくあることです。

しかし Rails では、あちらこちらのコードに手を入れる必要があります。「あれ？どれが修正したソースで、どれを納品すればいいんだっけ？ 納品するときの抜け漏れが心配だなぁ」そんな状況もよくあることです。

そんなときにこれがあれば、納品対象のソース管理が簡単になります。

* git と似たような感じで使えますが git よりシンプルです。
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
    Nouhin commands:
      nouhin add FILE        # FILE を納品対象としてインデックスに登録します.
      nouhin commit FILE     # 納品対象のファイルをまとめたアーカイブ FILE を作成します.
      nouhin compress FILE   # （同上)
      nouhin extract FILE    # アーカイブ FILE を展開します.
      nouhin expand FILE     # （同上)
      nouhin help [COMMAND]  # Describe available commands or one specific command
      nouhin init            # 納品対象を管理するインデックスファイル(~/nouhin_files.index)を初期化します.
      nouhin reset FILE      # FILE を納品対象から外します.
      nouhin delete FILE     # （同上)
      nouhin status          # 現在 納品対象として管理されているファイルを一覧で表示します.
      nouhin list            # （同上)
      nouhin -l              # （同上)

* ユーザーホームディレクトリ(~/)に、納品対象インデックス ` ~/nouhin_files.index` が作られます。
* 作成/修正したファイルを `nouhin add FILE` で納品対象としてマークします。
* 間違ってマークした場合は `nouhin reset FILE` で納品対象から外します。
* テストが完了して納品する段階になったら `nouhin commit FILE` で納品用アーカイブファイルを作ります。
* commit はワーキングツリーの表層、rails で言えば app_name/ あたりで実行するといいでしょう。
* 作成したアーカイブファイルを納品して終了です。
* 新しく納品対象を管理する場合は `nouhin init` で納品対象インデックスを初期化します。
* `nouhin init` するまでインデックスの内容は保持されます。

## Features

* simple is beautiful.
* ファイルのバージョンという概念はありません。差分(diff)という概念もありません。
* リモートだとかリポジトリだとかワーキングツリーという考え方もありません。
* もちろんユーザー登録だとか秘密鍵といった設定も必要ありません。
* あるのは「それが納品対象かどうか」だけです。
* simple is beautiful.
* 「バージョン管理ってよくわからないし、怖い」という方は意外と多いです。
* `nouihn add FILE`はファイルに「納品予定」という付箋を貼って歩くイメージです。
* `nouhin commit FILE`はそれらをひとまとめにして段ボールに放り込むイメージです。
* tar の展開オプションを覚えていますか？ 納品される側もこれからは `nouhin extract FILE` で一発です。

## FAQ
Q.`nouhin add FILE`した後でそのファイルの名前を変更しました。どうしたらいいですか？  
A.`nouhin reset OLDFILE`するか`~/nouhin_files.index`をエディタで開いて該当行を削除してください。その後あらためて`nouhin add NEWFILE`してください。


Q.`nouhin add FILE`するのは、ファイルの修正まえがいいですか？ 修正後にしたほうがいいですか？  
A.どちらでも構いません。「それが納品対象かどうか」だけを考えてください。`nouhin add FILE`はファイルに「納品予定」という付箋を貼るようなイメージです。


Q.納品ファイルの一覧を保存しておきたいのですが、どうすればいいですか？  
A.` ~/nouhin_files.index`を保管してください。そのファイルを復元することで再び同じファイルを commit することが可能になります。

Q.間違えて同じファイルを２回 add してしまいました。大丈夫ですか？  
A.問題ありません。commit したときに重複排除されます。それでも気になるようであれば`~/nouhin_files.index`をエディタで開いて該当行を削除することもできます。


## Requirement
command `tar`

## TODO
* `nouhin push` でリモートサーバーに SCP で送る機能必要？ もしくはメール送信？
* `nouhin pull` でリモートサーバーからアーカイブファイルを引っ張ってくる？ 
* tar コマンドがない環境では zip で圧縮する？ オプションで選べるようにする？
* `nouhin init`したディレクトリに`.nouhin｀をつくって、配下のディレクトリとファイルをバックアップしておく？
* バックアップファイルから checkout して元のファイルを復元できるようにする？
* そしてワーキングツリー上のコードと差分(diff)をとれるようにする？
* なんならバックアップファイルを世代管理できるようにする？
* そしてバックアップ側を「正」とみるようにして「リポジトリ」と呼ぶようにする？
* ついでに世代管理だけじゃなくてbrach をきれるようにしてワークツリー全体を切り替えられるようにする？

**もう git じゃん**
