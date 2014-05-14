require 'spec_helper'

describe Gist do
  let(:user) { FactoryGirl.create(:user) }
  before { @gist = user.gists.build(snippet: "<h1> sss </h1>", description: "This is html", lang: "html") }

  subject { @gist }
  it { should respond_to(:description) }
  it { should respond_to(:snippet) }
  it { should respond_to(:lang) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @gist.user_id = nil }
    it { should_not be_valid }
  end

 describe "with blank snippet" do
    before { @gist.snippet = " " }
    it { should_not be_valid }
  end

  describe "with snippet that is too long" do
    before { @gist.snippet = "a" * 1201 }
    it { should_not be_valid }
  end

end
