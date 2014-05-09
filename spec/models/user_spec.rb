require 'spec_helper'

describe User do
  before {
    @user = User.new(name: "Example User", email: "user@example.com") 
  }
  subject { @user } 
  
  it { should respond_to(:name) }
  #Alternative withouth subject
  #it "should responed to name" do
  # expect (@user).to respond_to(:name)
  #end

  
end
