module Nouhin
  class CLI < Thor
    desc "commit FILE", "納品対象のファイルをまとめたアーカイブ FILE を作成します."
    def commit(file)
      can_start?
      path = File.expand_path(file)
      basename = File.basename(path)
      basename << ".gz" unless basename =~ /\.gz$/
      basename.gsub!(/gz$/,"tar.gz") unless basename =~ /\.tar\.gz$/
      dirname = File.dirname(path)
      puts "[ #{dirname}/ ] に [ #{basename} ] を作成します."
      puts "よろしいですか？( y/n )"
      #
      (puts "停止します."; exit) unless gets.chomp == "y"
      files = File.read(@index_file_path)
      files.gsub!(/^#{dirname}/,".")
      puts `tar -C #{@root_path} -zcvf #{basename} #{files.split.uniq.join(" ")} #{exclude_options(@ignore_file_path)}`
      puts "[ #{dirname}/#{basename} ] を作成しました."
      puts "中身を確認する場合は [ extract FILE --test ] オプションを実行してください."
    end
  end
end
