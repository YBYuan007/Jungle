require 'rails_helper'

RSpec.feature "Visitor navigates to see product details", type: :feature , js: true do
  
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


  scenario "they see product details" do 
    visit root_path
    click_link "Details"
    # puts page.html
  
    save_screenshot
    expect(page).to have_css 'article.product-detail', count: 1
  end 

end
