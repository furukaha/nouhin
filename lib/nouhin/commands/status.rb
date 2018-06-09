module Nouhin
  class CLI < Thor
    desc "status", "現在 納品対象として管理されているファイルを一覧で表示します."
    def status
      can_start?
      File.foreach(@index_file_path){|f| puts f}
    end
  end
end
