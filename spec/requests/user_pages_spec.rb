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

  end
  
end
