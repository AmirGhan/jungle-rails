require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should save when all the fields are presence" do
      @category = Category.new(
        name: "Cell Phone"
      )
      @product = @category.products.new(
        name: "iPhone",
        price: 700,
        quantity: 10
      )
      expect(@product).to be_valid
    end

    it "should not be valid when the product name is missing" do
      @category = Category.new(
        name: "Cell Phone"
      )
      @product = @category.products.new(
        price: 700,
        quantity: 10
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not be valid when the price is missing" do
      @category = Category.new(
        name: "Cell Phone"
      )
      @product = @category.products.new(
        name: "iPhone",
        quantity: 10
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should not be valid when the quantity is missing" do
      @category = Category.new(
        name: "Cell Phone"
      )
      @product = @category.products.new(
        name: "iPhone",
        price: 700
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not be valid when the category is missing" do
      @product = Product.new(
        name: "iPhone",
        price: 700,
        quantity: 10
      )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
