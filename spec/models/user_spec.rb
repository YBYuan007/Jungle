require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do 

    it "must has all fields filled, password and password_confirmation must match, and password must have at least 5 letters" do 
      @user = User.new(first_name: "Cool", last_name:"Beans", email: "cool.beans@gmail.com",  password: "coolcoolcool", password_confirmation: "coolcoolcool")
      @user.save
      expect(@user).to be_valid  
    end 

    it "is not valid if password and password_confirmation are not the same" do 
      @user = User.new(first_name: "Cool", last_name:"Beans", email: "cool.beans@gmail.com", password: "thisisgreat", password_confirmation: "thisisnotgreat")
      @user.save
      expect(@user).to_not be_valid  
    end 

    it "must has password_confirmation" do 
      @user = User.new(first_name: "Cool", last_name:"Beans", email: "cool.beans@gmail.com", password: "thisisgreat")
      @user.save
      expect(@user).to_not be_valid  
    end 

    it "must has password" do 
      @user = User.new(first_name: "Cool", last_name:"Beans", email: "cool.beans@gmail.com",  password_confirmation: "thisisnotgreat"  )
      @user.save
      expect(@user).to_not be_valid  
    end 

    it "must has first_name" do 
      @user = User.new(last_name:"Beans", email: "cool.beans@gmail.com", password: "thisisgreat", password_confirmation: "thisisnotgreat" )
      @user.save
      expect(@user).to_not be_valid  
    end 

    it "must has last_name" do 
      @user = User.new(first_name: "Cool", email: "cool.beans@gmail.com",  password: "coolcoolcool", password_confirmation: "coolcoolcool")
      @user.save
      expect(@user).to_not be_valid  
    end 

    it "must has email" do 
      @user = User.new(first_name: "Cool", last_name:"Beans",   password: "coolcoolcool", password_confirmation: "coolcoolcool")
      @user.save
      expect(@user).to_not be_valid  
    end 

    
    it "must use unique email" do 
      User.create(first_name: "Cool", last_name:"Beans", email: "cool.beans@gmail.com",  password: "coolcoolcool", password_confirmation: "coolcoolcool")
      @user=User.create(first_name: "Cool", last_name:"Beans", email: "COOL.BEANS@gmail.com",  password: "coolcoolcool2", password_confirmation: "coolcoolcool2")
      expect(@user).to_not be_valid
    end 

    it "must longer than 5" do 
      @user=User.new(first_name: "Cool2", last_name:"Beans2", email: "COOL.BEANS@gmail.com",  password: "123", password_confirmation: "123")
      @user.save 
      expect(@user).to_not be_valid
    end 

  end 

  describe '.authenticate_with_credentials' do 
    it "can login with correct pw" do 
      User.create(first_name: "Cool", last_name:"Beans", email: "cool.beans@gmail.com",  password: "coolcoolcool", password_confirmation: "coolcoolcool") #create a user 
      @user=User.authenticate_with_credentials("cool.beans@gmail.com", "coolcoolcool")
      expect(@user).to be_truthy
    end

    it "cannot login with wrong pw" do 
      User.create(first_name: "Cool", last_name:"Beans", email: "cool.beans@gmail.com",  password: "coolcoolcool", password_confirmation: "coolcoolcool") #create a user 
      @user=User.authenticate_with_credentials("cool1111111111.beans@gmail.com", "coolcoolcool")
      expect(@user).to be_falsey 
    end

    it "can login with different email cases" do 
      User.create(first_name: "Cool", last_name:"Beans", email: "Cool.BeAns@gmail.com",  password: "coolcoolcool", password_confirmation: "coolcoolcool") #create a user 
      @user=User.authenticate_with_credentials("COOL.BEANS@gmail.com", "coolcoolcool")
      expect(@user).to be_truthy
    end

    it "can login with different email with extra spaces" do 
      User.create(first_name: "Cool", last_name:"Beans", email: "cool.beans@gmail.com",  password: "coolcoolcool", password_confirmation: "coolcoolcool") #create a user 
      @user=User.authenticate_with_credentials("     cool.beans@gmail.com      ", "coolcoolcool")
      expect(@user).to be_truthy
    end

  end 
end
