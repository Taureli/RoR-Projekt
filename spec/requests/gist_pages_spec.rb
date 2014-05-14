require 'spec_helper'

describe "GistPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
 

  describe "gist creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a gist" do
        expect { click_button "Post" }.not_to change(Gist, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'gist_snippet', with: "<h1> sss </h1>"}
      before { fill_in 'gist_description', with: "ZXZXZX" }
      before { select 'html', :from => 'gist_lang' }
      
      it "should create a gist" do
        expect { click_button "Post" }.to change(Gist, :count).by(1)
      end
    end
  end
end
