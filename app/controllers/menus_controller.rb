class MenusController < ApplicationController
    before_action :set_menu, only: [:show, :edit, :update, :destroy, :toggle_favourite]
  
    # GET /menus
    def index
      @menus = Menu.all
    end

    def toggle_favourite
      @menu.update(favourite: !@menu.favourite)  # Toggle true/false
      redirect_to menus_path, notice: "Updated favourite status."
    end

    def show
      @menu = Menu.find(params[:id])
    end
  
    # GET /menus/new
    def new
      @menu = Menu.new
    end
  
    # POST /menus
    def create
      @menu = Menu.new(menu_params)
      if @menu.save
        redirect_to menus_path, notice: 'Menu was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    # GET /menus/:id/edit
    def edit
    end
  
    # PATCH/PUT /menus/:id
    def update
      if @menu.update(menu_params)
        redirect_to menus_path, notice: 'Menu was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    # DELETE /menus/:id
    def destroy
      @menu.destroy
      redirect_to menus_path, notice: 'Menu was successfully deleted.'
    end
  
    private
  
    def set_menu
      @menu = Menu.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def menu_params
      params.require(:menu).permit(:name, :ingredients, :favourite)
    end
end
  