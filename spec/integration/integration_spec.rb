require 'spec_helper'

describe 'Visiting the root page' do
  before do
    visit new_url_path
  end

  it 'displays welcome text' do
    expect(page).to have_content("Welcome to URL Shortener!")
  end

  it 'submits the given URL to be shortened' do
    url = Url.create(original: 'http://www.testing.com/blablabla')
    fill_in 'Please enter a URL', :with => url.original
    click_button 'Submit'
    expect(page).to have_content("http://nis.ha/#{url.encode}")
  end
end
