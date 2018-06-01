require "nouhin/version"
require "fileutils"
require "thor"

module Nouhin
  class CLI < Thor
    package_name "nouhin"
    INDEX_FILE = "#{Dir.home}/nouhin_files.index"
    FileUtils.touch(INDEX_FILE) unless File.exist?(INDEX_FILE)

    desc "init", "納品対象を管理するインデックスファイル(~/nouhin_files.index)を初期化します."
    def init
      File.open(INDEX_FILE,'w'){|f| f = nil}
    end

    desc "add FILE", "FILE を納品対象としてインデックスに登録します."
    def add(file)
      path = file_check(file)
      File.open(INDEX_FILE,"a"){|f| f.puts path}
      puts "[ #{file} ] を納品対象としてマークしました。"
      puts "取り消しする場合は [ reset FILE ] オプションを実行してください。"
    end

    desc "reset FILE", "FILE を納品対象から外します."
    def reset(file)
      path = file_check(file)
      files = File.read(INDEX_FILE).split
      files.delete(path)
      File.open(INDEX_FILE,"w") do |f|
        files.each{|file| f.puts file }
      end
      puts "[ #{file} ] は納品対象から外れました。"
    end

    desc "status", "現在 納品対象として管理されているファイルを一覧で表示します."
    def status
      File.foreach(INDEX_FILE){|f| puts f}
    end
    desc "list", "現在 納品対象として管理されているファイルを一覧で表示します."
    alias_method :list, :status

    desc "commit FILE", "納品対象のファイルをまとめたアーカイブ FILE を作成します."
    def commit(file)
      path = File.expand_path(file)
      basename = File.basename(path)
      basename << ".gz" unless basename =~ /\.gz$/
      basename.gsub!(/gz$/,"tar.gz") unless basename =~ /\.tar\.gz$/
      dirname = File.dirname(path)
      puts "[ #{dirname}/ ] に [ #{basename} ] を作成します。"
      puts "[ #{dirname} ] をアーカイブの基点 [ ./ ] とします。"
      puts "よろしいですか？ [ y/n ]"
      #
      raise "停止します。" unless $stdin.gets.chomp == "y"
      files = File.read(INDEX_FILE)
      files.gsub!(/^#{dirname}/,".")
      puts `tar -zcvf #{basename} #{files.split.uniq.join(" ")}`
      puts "[ #{path} ] アーカイブファイルを作成しました。"
      puts "中身を確認する場合は [ test FILE ] オプションを実行してください。"
    end

    desc "compress FILE", "納品対象のファイルをまとめたアーカイブ FILE を作成します."
    alias_method :compress, :commit
    
    desc "test FILE", "アーカイブ FILE の中身を一覧で表示します."
    def test(file)
      path = file_check(file)
      puts `tar -ztvf #{path}`
    end

    desc "expand FILE", "アーカイブ FILE を展開します."
    def expand(file)
      path = file_check(file)
      puts `tar -ztvf #{path}`
      puts "現在のディレクトリ [ ./ ] を基点として、上記のファイルを展開します。"
      puts "よろしいですか？ [ y/n ]"
      #
      raise "停止します。" unless $stdin.gets.chomp == "y"
      puts `tar -zxvf #{path}`
    end

    private
    def file_check(file)
      path = File.expand_path(file)
      raise "ファイルが存在しません。" if !File.exist?(path)
      return path
    end
  end
end
