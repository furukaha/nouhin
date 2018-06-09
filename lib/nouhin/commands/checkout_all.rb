module Nouhin
  class CLI < Thor
    desc "checkout_all", "作業領域にあるすべての修正内容を取り消して修正前の状態に復元します."
    def checkout_all
      can_start?
      puts "作業領域にあるすべてのファイルを修正前の状態に復元します."
      puts "作業領域で修正した内容はすべて取り消されます."
      puts "よろしいですか？( y/n )"
      #
      (puts "停止します."; exit) unless gets.chomp == "y"
      puts `tar -C #{@root_path} -zxvf #{@repository_file_path}`
      puts "作業領域にあるすべてのファイルを修正前の状態に復元しました."
    end
  end
end
