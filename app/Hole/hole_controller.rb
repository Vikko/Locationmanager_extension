require 'rho/rhocontroller'
require 'helpers/browser_helper'

class HoleController < Rho::RhoController
  include BrowserHelper

  # GET /Hole
  def index
    @holes = Hole.find(:all)
    render :back => '/app'
  end

  # GET /Hole/{1}
  def show
    @hole = Hole.find(@params['id'])
    if @hole
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Hole/new
  def new
    @hole = Hole.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Hole/{1}/edit
  def edit
    @hole = Hole.find(@params['id'])
    if @hole
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Hole/create
  def create
    @hole = Hole.create(@params['hole'])
    redirect :action => :index
  end

  # POST /Hole/{1}/update
  def update
    @hole = Hole.find(@params['id'])
    @hole.update(@params['hole']) if @hole
    redirect :action => :index
  end

  # POST /Hole/{1}/delete
  def delete
    @hole = Hole.find(@params['id'])
    @hole.destroy if @hole
    redirect :action => :index  
  end
end
