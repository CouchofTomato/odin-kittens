class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json { render :json => @kittens }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.create(kitten_params)
    if @kitten.save
      flash[:success] = "Kitten created. Huzzah"
      redirect_to kitten_path(@kitten)
    else
      flash.now[:error] = "You done fucked up"
      render 'new'
    end

  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @kitten }
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    if @kitten.update_attributes(kitten_params)
      flash[:success] = "Kitten updated. All is well"
      redirect_to @kitten
    else
      flash.now[:error] = "What the fuck did you do"
    end
  end

  def destroy
    Kitten.find(params[:id]).destroy
    flash[:success] = "You killed the kitty"
    redirect_to kittens_url
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
