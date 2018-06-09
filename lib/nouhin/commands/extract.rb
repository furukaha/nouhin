module Nouhin
  class CLI < Thor
    desc "extract FILE", "アーカイブ FILE を展開します."
    option test: false, :aliases => '-t', desc: "実際に展開せずに、一覧を表示します."
    option :dir, :aliases => "-d", desc: "[ .nouhin/* ] を作成するディレクトリを指定します."
    def extract(file)
      path = file_check(file)
      # --test が指定されていたらアーカイブの内容を一覧表示して終了
      (puts `tar -ztvf #{path}`; exit) if options.test?
      #
      base = options[:dir] || "."
      puts `tar -C #{base} -ztvf #{path}`
      puts "現在のディレクトリ [ ./ ] を基点として、上記のファイルを展開します."
      puts "よろしいですか？( y/n )"
      #
      (puts "停止します."; exit) unless gets.chomp == "y"
      puts `tar -zxvf #{path}`
    end
  end
end
