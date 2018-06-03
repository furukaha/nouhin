require "spec_helper.rb"
require "nouhin"
#require "fileutils"
require "tmpdir"

RSpec.describe Nouhin do
  it "has a version number" do
    expect(Nouhin::VERSION).not_to be nil
  end

  before(:all) do
    #stub_const("Nouhin::CLI::INDEX_FILE", "#{ENV['TMP']}/nouhin_files_rspec.index")
    Nouhin::CLI::INDEX_FILE = "#{Dir.tmpdir}/nouhin_files_rspec.index"
    Dir.chdir("spec/fixtures/server_b/")
    FileUtils.rm_rf(  Dir.glob('./dir*') )
    Dir.chdir("../server_a/")
    FileUtils.rm_rf(  Dir.glob('./*.tar.gz') )
  end

  it "init - add - status - reset" do
    file111 = "dir1/dir11/file_1_11"
    path = File.expand_path(file111)

    $stdin = StringIO.new("y")
    Nouhin::CLI.new.init
    expect{ Nouhin::CLI.new.status }.to output("").to_stdout
    Nouhin::CLI.new.add file111
    expect{ Nouhin::CLI.new.status }.to output(path+"\n").to_stdout
    Nouhin::CLI.new.reset file111
    expect{ Nouhin::CLI.new.status }.to output("").to_stdout
    $stdin = STDIN
  end

  it "commit - extract" do
    file111 = "dir1/dir11/file_1_11"
    file112 = "dir1/dir12/file_1_12"
    file12  = "dir2/file_2"

    $stdin = StringIO.new("y")
    Nouhin::CLI.new.init
    Nouhin::CLI.new.add file111
    Nouhin::CLI.new.add file112
    Nouhin::CLI.new.add file12
    $stdin = StringIO.new("y")
    Nouhin::CLI.new.commit "test"
    expect(File.exist?("./test.tar.gz")).to be true
    Dir.chdir("../server_b/")
    $stdin = StringIO.new("y")
    Nouhin::CLI.new.extract "../server_a/test.tar.gz"
    expect(File.exist?("./dir2/file_2")).to be true
    $stdin = STDIN
  end

end
