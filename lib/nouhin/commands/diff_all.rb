module Nouhin
  class CLI < Thor
    desc "diff_all", "納品対象のファイルすべて、修正前の状態と比較し差分を表示します."
    def diff_all
      can_start?
      File.foreach(@index_file_path) do |file|
        #invoke :diff, [file.chomp]
        diff(file.chomp)
      end
    end
  end
end
