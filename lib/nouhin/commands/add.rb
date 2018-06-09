module Nouhin
  class CLI < Thor
    desc "add FILE", "FILE を納品対象としてインデックスに登録します."
    def add(file)
      can_start?
      path = file_check(file)
      File.open(@index_file_path,"a"){|f| f.puts path}
      puts "[ #{file} ] を納品対象としてマークしました."
      puts "取り消しする場合は [ reset FILE ] オプションを実行してください."
    end
  end
end
