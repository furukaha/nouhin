module Nouhin
  class CLI < Thor
    desc "diff FILE", "作業領域にある FILE について、修正前の状態と比較し差分を表示します."
    def diff(file)
      can_start?
      path = file_check(file)
      archive_file = path.gsub(/#{@root_path}/, ".")
      Dir.mktmpdir("nouhin") do |dir|
        `tar -C #{dir} -zxvf #{@repository_file_path} #{archive_file}`
        archive_file_path = archive_file.gsub(/^\./, "#{dir}")
        puts `diff -uwB #{archive_file_path} #{file}`
      end
    end
  end
end
