require 'spec_helper'

describe "Static pages" do

 describe "Contact page" do

    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact')
    end
  end

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
  end
  describe "About page" do

    it "should have the content 'About this task'" do
      visit '/static_pages/about'
      expect(page).to have_content('About this task')
    end
  end
   it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("About Us")
    end
end