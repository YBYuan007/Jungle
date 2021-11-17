require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature,  js: true do
  before :each do 
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name: Faker::Hipster.sentence(3), 
      description: Faker::Hipster.paragraph(4), 
      image: open_asset('apparel1.jpg'),
      quantity: 10, 
      price: 100.88
    )
  end 

  scenario "cart number increase" do 
    visit root_path
    click_on "Add"
    # puts page.html
    
    save_screenshot
    expect(page).to have_content "My Cart (1)"
  end 
end
