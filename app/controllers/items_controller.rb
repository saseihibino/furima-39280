class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    unless current_user.id == @item.user.id
      redirect_to action: :index 
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :delivery_charge_id, :prefecture_id,
                                 :day_to_send_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item 
    @item = Item.find(params[:id])
  end
end
