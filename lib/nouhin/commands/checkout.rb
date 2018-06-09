module Nouhin
  class CLI < Thor
    desc "checkout FILE", "指定の FILE の修正内容を取り消して修正前の状態に復元します."
    def checkout(file)
      can_start?
      path = fpath(file)
      puts "[ #{path} ] を修正前の状態に復元します."
      puts "修正した内容は取り消されます."
      puts "よろしいですか？( y/n )"
      #
      (puts "停止します."; exit) unless gets.chomp == "y"
      path.gsub!(/#{@root_path}/, ".")
      puts `tar -C #{@root_path} -zxvf #{@repository_file_path} #{path}`
      puts "[ #{path} ] を修正前の状態に復元しました."
    end
  end
end
