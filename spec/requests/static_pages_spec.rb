require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Impact Stats'" do
      visit '/static_pages/home'
      page.should have_content('Impact Stats')
    end
  end
end