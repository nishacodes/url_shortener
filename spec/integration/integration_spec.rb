require 'spec_helper'

describe 'Shortening a URL' do
  before do
    visit new_url_path
    url = Url.new(original: 'http://www.testing.com/blablabla')
    fill_in 'Please enter a URL', :with => url.original
  end

  it 'displays welcome text' do
    expect(page).to have_content("Welcome to URL Shortener!")
  end

  it 'submits the given URL to be shortened' do
    click_button 'Submit'
    url = Url.last
    # debugger
    expect(page).to have_content("#{url.shortened}")
  end

  it 'displays a success notice after submitted' do
    click_button 'Submit'
    expect(page).to have_content("URL has been shortened!")
  end

  it 'links to the original URL address' do 
    click_button 'Submit'
    url = Url.last
    find_link(url.shortened)[:href].should == "#{url.original}"
  end
end

