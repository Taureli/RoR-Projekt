require 'spec_helper'

describe Gist do
  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @gist = Gist.new(content: "Lorem ipsum", user_id: user.id)
  end

  subject { @gist }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
end
