require 'rails_helper'


describe :root do
  it 'should render the users' do
    visit root_path
    expect(page.find('h1')).to have_content('Users')
  end

end
