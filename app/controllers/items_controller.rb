class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  
  def index
    @items = Item.all.order('created_at DESC')
  end

  def show
  end

  def new
    @item = current_user.new
  end

  def create
    @item = current_user.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :description)
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
