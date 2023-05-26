class ItemsController < ApplicationController
  # def index
  #   @items = Item.all
  # end

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

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :delivery_charge_id, :prefecture_id,
                                 :day_to_send_id, :price, :image).merge(user_id: current_user.id)
  end
end
