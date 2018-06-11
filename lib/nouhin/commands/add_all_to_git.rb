module Nouhin
  class CLI < Thor
    desc "add_all_to_git", "納品対象のファイルをすべて [ git add ] します."
    def add_all_to_git
      can_start?
      File.foreach(@index_file_path) do |file|
        `git add #{file.chomp}`
        puts "#{file.chomp} を git add しました."
      end
    end
  end
end
