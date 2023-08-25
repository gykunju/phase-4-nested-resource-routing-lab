class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
      render json: items
    else
      render json: Item.all, include: :user
    end
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create!(item_params)
    render json: item, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: {errors: e.record.errors.full_messages}
  end

  private

  def item_params
    params.permit(:id, :name, :description, :price)
  end

end
