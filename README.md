# Nouhin

納品物管理コマンドライン・ツール(CLI) - アーカイブでの納品を求められる環境下で、納品対象物を管理するためのコマンド.


## Description

git でバージョン管理するほどの案件ではなかったり、リモートで顧客とつながるほどの案件でなかったり、アーカイブ納品で済んでしまう状況はよくあることです。

しかし Rails では、あちらこちらのコードに手を入れる必要があります。「あれ？どれが修正したソースで、どれを納品すればいいんだっけ？ 納品するときの抜け漏れが心配だなぁ」そんな状況もよくあることです。

そんなときにこれがあれば、納品対象のソース管理が簡単になります。

* git と似たような感じで使えますが git よりシンプルです。
* add で納品対象ステージに追加して、reset でアンステージします。commit で納品対象物をアーカイブ化(tar.gz)します。
* ローカル完結です。なので、リモートも ssh-key の設定なども必要ありません。


詳しい使い方は `nouhin help [COMMAND]` を参照してください。


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
      nouhin add_all_to_git  # 納品対象のファイルをすべて [ git add ] します.
      nouhin checkout FILE   # 指定の FILE を修正前の状態に復元します.
      nouhin checkout_all    # 作業領域にあるすべてのファイルを修正前の状態に復元します.
      nouhin commit FILE     # 納品対象のファイルをまとめたアーカイブ FILE を作成します.
      nouhin diff FILE       # 作業領域にある FILE について、修正前の状態と比較し差分を表示します.
      nouhin diff_all        # 納品対象のファイルすべて、修正前の状態と比較し差分を表示します.
      nouhin extract FILE    # アーカイブ FILE を展開します.
      nouhin help [COMMAND]  # Describe available commands or one specific command
      nouhin init            # 納品対象を管理する [ .nouhin/* ] を作成/初期化します.
      nouhin reset FILE      # FILE を納品対象から外します.
      nouhin status          # 現在 納品対象として管理されているファイルを一覧で表示します.
    
    Options:
      [--force]  # メッセージインターフェイスを抑制し強制的に実行します.


* 作業ディレクトリの上位で `nouhin init`を実行します。`./.nouhin/`ディレクトリが作成されます。
* `./.nouhin/`の存在するディレクトリより配下のツリーを作業領域と呼びます。
* 作成/修正したファイルを `nouhin add FILE` で納品対象としてマークします。
* 間違ってマークした場合は `nouhin reset FILE` で納品対象から外します。
* テストが完了して納品する段階になったら `nouhin commit FILE` で納品用アーカイブファイルを作ります。
* commit は作業ツリーの表層、rails で言えば app_name/ あたりで実行するといいでしょう。
* 作成したアーカイブファイルを納品して終了です。
* `nouhin diff FILE` で修正前の状態と差分を表示することができます。
* `nouhin checkout FILE` で修正内容を取り消して修正前の状態に復元することができます。
* 新しく納品対象を管理する場合は `nouhin init` で納品対象インデックスを初期化します。
* `nouhin init` するか `./.nouhin/`ディレクトリを削除するまでインデックスの内容は保持されます。


## Features

* ファイルのバージョンという概念はありません。（修正前の状態という概念はあります）
* リモートだとかリポジトリという考え方もありません。
* もちろんユーザー登録だとか秘密鍵といった設定も必要ありません。
* あるのは「それが納品対象かどうか」だけです。
* simple is beautiful.
* 「バージョン管理ってよくわからないし、怖い」という方は意外と多いです。
* `nouihn add FILE` はファイルに「納品予定」という付箋を貼って歩くイメージです。
* `nouhin commit FILE` はそれらをひとまとめにして段ボールに放り込むイメージです。


## FAQ
Q.`nouhin add FILE` した後でそのファイルの名前を変更しました。どうしたらいいですか？  
A.`nouhin reset OLDFILE` を実行してください。その後あらためて `nouhin add NEWFILE` してください。


Q.`nouhin add FILE` するのは、ファイルの修正まえがいいですか？ 修正後にしたほうがいいですか？  
A.どちらでも構いません。「それが納品対象かどうか」だけを考えてください。`nouhin add FILE` はファイルに「納品予定」という付箋を貼るようなイメージです。


Q.納品ファイルの一覧を保存しておきたいのですが、どうすればいいですか？  
A.`.nouhin/nouhin_files.index` を保管してください。そのファイルを復元することで再び同じファイルを commit することが可能になります。


Q.間違えて同じファイルを２回 add してしまいました。大丈夫ですか？  
A.問題ありません。commit する際に重複排除されます。


Q.間違った場所で `nouhin init` してしまいました。どうしたらいいですか？  
A.そのディレクトリに作成された `.nouhin/` ディレクトリを削除してください。


## Requirement
* system-command `tar`
* system-command `diff`


## TODO
* tar コマンドがない環境では zip で圧縮する？ オプションで選べるようにする？
* なんなら修正前のファイルを commit ごとに世代管理できるようにする？
* ついでに世代管理だけじゃなくてbranch をきれるようにしてワークツリー全体を切り替えられるようにする？
* そして世代管理されている資源を「リポジトリ」と呼ぶようにする？
* `nouhin push` でリモートサーバーにアーカイブを送る？
* `nouhin pull` でリモートサーバーからアーカイブファイルを引っ張ってくる？ 

**もう git じゃん**
