# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index; end

  def new
    @category = Category.new
  end

  def show; end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category was successfully created'
      redirect_to @category
    else
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
