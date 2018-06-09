require "spec_helper.rb"
require "nouhin"
require "fileutils"
require "tmpdir"

RSpec.describe Nouhin do
  it "has a version number" do
    expect(Nouhin::VERSION).not_to be nil
  end

  before(:all) do
    Dir.chdir("#{File.dirname(__FILE__)}/fixtures/server_b/")
    FileUtils.rm_rf(  Dir.glob('./dir*') )
    Dir.chdir("../server_a/")
    FileUtils.rm_rf(  Dir.glob('./*.tar.gz') )
  end

  it "init - add - status - reset" do
    file111 = "dir1/dir11/file_1_11"
    path = File.expand_path(file111)

    #Nouhin::CLI.new.init [], {force: true}
    Nouhin::CLI.new.invoke(:init, [], {force: true})
    expect{ Nouhin::CLI.new.status }.to output("").to_stdout
    Nouhin::CLI.new.invoke(:add, [file111], {force: true})
    expect{ Nouhin::CLI.new.status }.to output(path+"\n").to_stdout
    Nouhin::CLI.new.invoke(:reset, [file111], {force: true})
    expect{ Nouhin::CLI.new.status }.to output("").to_stdout
  end

  it "commit - extract" do
    make_archive()
    expect(File.exist?("./test.tar.gz")).to be true
    Dir.chdir("../server_b/")
    Nouhin::CLI.new.invoke(:extract, ["../server_a/test.tar.gz"],  {force: true, "-d": "../server_b/"})
    expect(File.exist?("./dir2/file_2")).to be true
  end

  it "checkout - checkout_all" do
    make_archive()
    File.write("dir2/file_2", "change!")
    Nouhin::CLI.new.invoke(:checkout, ["dir2/file_2"],  {force: true})
    expect( File.read("dir2/file_2") ).to eq "test dir2\n"

    File.write("dir2/file_2", "change!")
    Nouhin::CLI.new.invoke(:checkout_all, [],  {force: true})
    expect( File.read("dir2/file_2") ).to eq "test dir2\n"
  end

  it "diff - diff_all" do
    make_archive()
    File.write("dir2/file_2", "diffdiff")
    expect{
      Nouhin::CLI.new.invoke(:diff, ["dir2/file_2"])
    }.to output(/diffdiff/).to_stdout

    File.write("dir2/file_2", "diffdiff")
    expect{
      Nouhin::CLI.new.invoke(:diff_all, [])
    }.to output(/diffdiff/).to_stdout

    Nouhin::CLI.new.invoke(:checkout_all, [],  {force: true})
  end

end

def make_archive
  Dir.chdir("#{File.dirname(__FILE__)}/fixtures/server_a/")

  file111 = "dir1/dir11/file_1_11"
  file112 = "dir1/dir12/file_1_12"
  file12  = "dir2/file_2"

  Nouhin::CLI.new.invoke(:init,   [],        {force: true})
  Nouhin::CLI.new.invoke(:add,    [file111], {force: true})
  Nouhin::CLI.new.invoke(:add,    [file112], {force: true})
  Nouhin::CLI.new.invoke(:add,    [file12],  {force: true})
  Nouhin::CLI.new.invoke(:commit, ["./test"],  {force: true})
end
