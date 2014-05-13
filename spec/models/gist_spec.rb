require 'spec_helper'

describe Gist do
  let(:user) { FactoryGirl.create(:user) }
  before { @gist = user.gists.build(content: "Lorem ipsum") }

  subject { @gist }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @gist.user_id = nil }
    it { should_not be_valid }
  end

 describe "with blank content" do
    before { @gist.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @gist.content = "a" * 1201 }
    it { should_not be_valid }
  end

end
