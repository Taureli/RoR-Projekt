require 'spec_helper'

describe User do
  before {
    @user = User.new(name: "Jarek Konio", email: "konie@bdimension.com", password: "koniowo", password_confirmation: "koniowo") 
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

  #Check for response to session token:
  it { should respond_to(:remember_token) }
  
  #Check if responds to the email-password authentication
  it { should respond_to(:authenticate) }


  it { should respond_to(:admin) }
  it { should respond_to(:gists) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end





  
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
    before { @user.name = "z" * 60 }
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
  
   describe "password too short" do
	before { @user.password = "z" * 5, @user.password_confirmation = "z" * 5}
	it { should be_invalid }
   end
  
  describe "should not be valid without password" do
    before do
      @user = User.new(name: "Jarek", email: "jarek@bdimension.com", password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end
  
  describe "should not be valid with mismatch" do
    before { @user.password_confirmation = "other" }
    it { should_not be_valid }
  end
  
  #Authenticate the user, if the user email matches the password
	describe "authenticate the user" do
	  before { @user.save }
	  #Assign a user found by email to found_user variable
	  let(:found_user) { User.find_by(email: @user.email) }
	  
	  #Authenticate if the email user(found_user) equals user password
	  describe "password should be valid" do
		it { should eq found_user.authenticate(@user.password) }
	  end

	  describe "password should be invalid" do
		#Assign 
		let(:user_for_invalid_password) { found_user.authenticate("invalid") }
		#The found user should not equal with the valid authentication
		it { should_not eq user_for_invalid_password }
		#Expect the user the user authentication to be false
		it { expect(user_for_invalid_password).to be_false }
	  end
	end

  #Check if user has assigned token before saving
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end	
	
end
