require 'spec_helper'

describe User do
  before {
    @user = User.new(name: "Example User", email: "user@example.com") 
  }
  subject { @user } 
  
  #Check if username is saved
  it { should respond_to(:name) }
  #Alternative withouth subject
  #it "should responed to name" do
  # expect (@user).to respond_to(:name)
  #end
  
  #Check if email is saved
  it { should respond_to(:email) }
  
  #Check if is valid
  it { should be_valid }
  
  #Not valid without name
	describe "should not be valid without name presence" do
	  before { @user.name = " " }
	  it { should_not be_valid }
	end
	
   #Not valid without email
	describe "should not be valid without email presence" do
	  before { @user.email = " " }
	  it { should_not be_valid }
	end
end
