require 'spec_helper'

describe "User pages" do
  

  subject { page }

  describe "profile page" do 
  	let(:user) {FactoryGirl.create(:user)}
  	before {visit user_path(user)}

  	it {should have_content(user.name)}
  	it {should have_title(user.name)}
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup path" do 
    before { visit signup_path}

    let(:sumbit) { "Create my account" }

    describe "with invalid information" do 
      it "should not create a user" do 
        expect { click_button sumbit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do 
      before do 
        fill_in "Name",           with: "Example user"
        fill_in "Email",          with: "user@example.com"
        fill_in "Password",       with: "foobar"
        fill_in "Confirmation",   with: "foobar"
      end
      it "should create a user" do 
        expect { click_button sumbit }.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        let(:submit) { "Sign up" }
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
      # тест выхода пользователя
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end  
end