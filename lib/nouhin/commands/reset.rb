module Nouhin
  class CLI < Thor
    desc "reset FILE", "FILE を納品対象から外します."
    def reset(file)
      can_start?
      path = fpath(file)
      files = File.read(@index_file_path).split
      files.delete(path)
      File.open(@index_file_path,"w") do |f|
        files.each{|file| f.puts file }
      end
      puts "[ #{file} ] は納品対象から外れました."
    end
  end
end
