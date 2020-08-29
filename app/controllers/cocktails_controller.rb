class CocktailsController < ApplicationController
  before_action :set_cocktail, only: %i[show edit update destroy]

  def index
    @cocktails = Cocktail.all.order('name ASC')
    @cocktails = Cocktail.search(params[:search]) if params[:search]
  end

  def show
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @cocktail.update(_params)
      redirect_to cocktail_path(@cocktail.id)
    else
      render :edit
    end
  end

  def destroy
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def _params
    params.require(:cocktail).permit(:name, :photo, :search)
  end
end
