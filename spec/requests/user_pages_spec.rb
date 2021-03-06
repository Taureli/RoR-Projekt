require 'spec_helper'

describe "User pages" do

  subject { page }


  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Konik", email: "jarek@konie.com")
      FactoryGirl.create(:user, name: "Konik", email: "kon@konie.com")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }


      describe "pagination" do

        before(:all) { 30.times { FactoryGirl.create(:user) } }
        after(:all)  { User.delete_all }

        it { should have_selector('div.pagination') }


      it "should list each user" do
       User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

   describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end





  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end
  
  describe "profile page" do
	  let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:gist, user: user, snippet: "Foo", description: "This is html", lang: "html") }
    let!(:m2) { FactoryGirl.create(:gist, user: user, snippet: "Bar", description: "This is html", lang: "html") }
	  before { visit user_path(user) }

	  it { should have_content(user.name) }
	  it { should have_title(user.name) }
    describe "gists" do
      it { should have_content(m1.snippet) }
      it { should have_content(m2.snippet) }
      it { should have_content(user.gists.count) }
    end
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

  end
  


describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end



    describe "with valid information" do

      let(:new_name)  { "Konik" }
      let(:new_email) { "kon@unicorns.pl" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }

      #check if everythin is in place after logging in
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'konie@bdimension.com') }
      end
    end





  end



end
