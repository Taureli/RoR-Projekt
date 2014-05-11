require 'spec_helper'

describe User do
  before {
    @user = User.new(name: "Example User", email: "user@example.com", password: "pass", password_confirmation: "pass") 
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
  
  #Check if responds to password
  it { should respond_to(:password_digest) }
  
  #Check if it responds to password
  it { should respond_to(:password) }
  
  #Check if it responds to the password confirmation
  it { should respond_to(:password_confirmation) }
  
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
  
  describe "email format should be valid" do
    it "should be valid" do
      emails = %w[jarek@konie.PL kon.kon@sss.is a@kon.com Jarek_Kon-Kuba@kon.a.org kon-ww@kon.com]
      emails.each do |valid_email|
        @user.email = valid_email
        expect(@user).to be_valid
      end
    end
  end
  
  describe "should not be valid when email is taken" do
    before do
      duplicate_email = @user.dup #duplicates the user
      duplicate_email.save 
    end
    it { should_not be_valid }
  end
  
end
