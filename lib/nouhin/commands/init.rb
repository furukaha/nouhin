module Nouhin
  class CLI < Thor
    desc "init", "納品対象を管理する [ .nouhin/* ] を作成/初期化します."
    option :dir, :aliases => "-d", desc: "[ .nouhin/* ] を作成するディレクトリを指定します."
    def init
      nouhin_dir = ".nouhin"
      base = options[:dir] || "."
      dot_nouhin_path = base + "/" + nouhin_dir
      if init_target?("Dir", dot_nouhin_path, "処理を続けますか？") then
        FileUtils.rm_r(dot_nouhin_path) if Dir.exist?(dot_nouhin_path)
        Dir.mkdir(dot_nouhin_path) unless Dir.exist?(dot_nouhin_path)
        puts "[ #{base} ] に [ #{nouhin_dir} ] ディレクトリを作成しました."
      else
        puts "停止します."; exit
      end

      ignore_file = "nouhinignore"
      ignore_file_path = dot_nouhin_path + "/" + ignore_file
      template_file_path = "#{File.dirname(__FILE__)}/template_ignore"
      FileUtils.cp(template_file_path, ignore_file_path)
      #puts "イグノアファイル [ #{ignore_file_path} ] を初期作成しました."

      index_file = "nouhin_files.index"
      index_file_path = dot_nouhin_path + "/" + index_file
      File.open(index_file_path,"w"){|f| f = nil}
      #puts "インデックスファイル [ #{index_file_path} ] を初期作成しました."

      repository_file = "repository.tar.gz"
      repository_file_path = dot_nouhin_path + "/" + repository_file
      `tar -zcvf #{repository_file_path} #{base} #{exclude_options(ignore_file_path)} --exclude ".nouhin"`
      #puts "バックアップファイル [ #{repository_file_path} ] を初期作成しました."
    end

    no_commands do
      def init_target?(klass,path,msg)
        ret = "y"
        if Object.const_get(klass).exist?(path) then
          puts "すでに #{File.basename(path)} が存在します."
          puts "#{msg} ( y/n )"
          ret = gets.chomp
        end
        return ret == "y" ? true : false
      end
    end

  end
end
