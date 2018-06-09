require "nouhin/version"
require "fileutils"
require "tmpdir"
require "thor"
Dir.glob("#{File.dirname(__FILE__)}/nouhin/commands/*rb").each{|file| require file}

module Nouhin
  class CLI < Thor
    package_name "Nouhin"
    map "compress" => :commit
    map "delete" => :reset
    map "remove" => :reset
    map "list" => :status
    map "-l" => :status
    map "expand" => :extract
    class_option :force, :type => :boolean, :desc => "メッセージインターフェイスを抑制し強制的に実行します."

    def initialize(*args)
      super(*args)
      @dot_nouhin_path = dot_nouhin_path
      return @can_start = false unless @dot_nouhin_path
      @root_path = File.dirname(@dot_nouhin_path)
      @index_file_path = @dot_nouhin_path + "/nouhin_files.index"
      @ignore_file_path = @dot_nouhin_path + "/nouhinignore"
      @repository_file_path = @dot_nouhin_path + "/repository.tar.gz"
      return @can_start = true
    end

    private
    # 実行場所が作業ツリーの範囲内でなければ停止する
    def can_start?
      (puts "ここは作業領域ではありません.停止します."; exit) unless @can_start
    end

    # ignore ファイルから tar の exclude オプションを生成する
    def exclude_options(ignore_file_path)
      ar = File.read(ignore_file_path)
      ar = ar.split("\n")
      ar.map! do |r|
        r.gsub!(/#.*$/,""); r.gsub!(/^\s*?$/,"")
        r.gsub!(/^\//,"./"); r.gsub!(/\/$/,"/*")
        r
      end
      ar =  ar.delete_if{|r|r==""}
      ar.map! do |r|
        "--exclude '" + r + "'"
      end
      return ar.join(" ")
    end

    # .nouhin ディレクトリを現在のディレクトリからさかのぼって探す
    def dot_nouhin_path
      Dir.pwd.split("/").count.times do |n|
        path = "../"*n + ".nouhin/"
        return File.expand_path(path) if Dir.exist?(path)
      end
      return false
    end

    # --force が指定されていたらメッセージインターフェイス抑制
    def puts(msg)
      super unless options[:force]
    end

    # モンキーパッチ
    def gets
      return options[:force] ? "y"  : $stdin.gets
    end

    # 対象ファイル存在チェック
    def fpath(file)
      File.expand_path(file)
    end

    def file_check(file)
      path = fpath(file)
      (puts "ファイルが存在しません."; exit) if !File.exist?(path)
      return path
    end # def
  end # class
end # module
