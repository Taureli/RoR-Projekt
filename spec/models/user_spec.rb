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
  
  #Not valid, name too long	
  describe "should not be valid with too long name" do
    before { @user.name = "z" * 16 }
    it { should_not be_valid }
  end
  
  
  describe "email format should be invalid" do
    it "should be invalid" do
      emails = %w[email@adam,wp jarek_at_kuba.pl jarek.konie@konie.
                     konie@kon_kon.com wzzxxz@zz/aa.com faxzxz@kon+kon.org ]
      emails.each do |invalid_email|
        @user.email = invalid_email
        expect(@user).not_to be_valid
      end
    end
  end
  
end
