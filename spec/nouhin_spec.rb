require "spec_helper.rb"
require "nouhin"

RSpec.describe Nouhin do
  it "has a version number" do
    expect(Nouhin::VERSION).not_to be nil
  end
end
