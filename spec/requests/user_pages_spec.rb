require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end
  
  describe "profile page" do
	  let(:user) { FactoryGirl.create(:user) }
	  before { visit user_path(user) }

	  it { should have_content(user.name) }
	  it { should have_title(user.name) }
  end
  
  #signup using capybara
  describe "sign-up" do
    before { visit signup_path }
    #define the submit as "Create my account"
    let(:submit) { "Create my account" }

    #If invalid the users count should not increase
    describe "with invalid input" do
      it "should not create new user" do
		#Capybara "makes" the click on submit
        expect { click_button submit }.not_to change(User, :count)
      end
    end
	
	#Define valid input
    describe "valid input" do
      before do
        fill_in "Name",         with: "Jarek Konio"
        fill_in "Email",        with: "konie@bdimension.com"
        fill_in "Password",     with: "koniowo"
        fill_in "Confirmation", with: "koniowo"
      end
	  #successful user creation, user count increases
      it "should create a new user" do
		#Capybara "makes" the click on submit
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end

    describe "with valid information" do

    	#check if everythin is in place after logging in
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

    end

  end
  
end
