require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do 

    it "should be saved to the db if everything is filled up " do 
      @category = Category.new 
      @product = Product.new(name: "applejuice", price: 100, quantity: 10, category: @category)
      @product.save
      # expect(@product.name).to be_present
      expect(@product).to be_valid
    end 

    it "is not valid without a name" do 
      @category = Category.new 
      @product = Product.new(name: nil, price: 100, quantity: 10, category: @category)
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")   
    end 

    it "is not valid without a price " do 
      @category = Category.new 
      @product = Product.new(name: "applejuice", price: nil, quantity: 10, category: @category)
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")   
    end 

    it "is not valid without a quantity" do
      @category = Category.new 
      @product = Product.new(name: "applejuice", price: 100, quantity: nil, category: @category)
      @product.save
      expect(@product).to_not be_valid 
      expect(@product.errors.full_messages).to include("Quantity can't be blank")   
    end 

    it "is not valid without a category" do 
      @product = Product.new(name: "applejuice", price: 100, quantity: 10, category: nil)
      @product.save
      expect(@product).to_not be_valid 
      expect(@product.errors.full_messages).to include("Category can't be blank")   
    end 


  end 
end
