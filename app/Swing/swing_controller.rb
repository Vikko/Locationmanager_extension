require 'rho/rhocontroller'
require 'helpers/browser_helper'

class SwingController < Rho::RhoController
  include BrowserHelper

  # GET /Swing
  def index
    @swings = Swing.find(:all)
    render :back => '/app'
  end

  # GET /Swing/{1}
  def show
    @swing = Swing.find(@params['id'])
    if @swing
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Swing/new
  def new
    @swing = Swing.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Swing/{1}/edit
  def edit
    @swing = Swing.find(@params['id'])
    if @swing
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Swing/create
  def create
    @swing = Swing.create(@params['swing'])
    redirect :action => :index
  end

  # POST /Swing/{1}/update
  def update
    @swing = Swing.find(@params['id'])
    @swing.update_attributes(@params['swing']) if @swing
    redirect :action => :index
  end

  # POST /Swing/{1}/delete
  def delete
    @swing = Swing.find(@params['id'])
    @swing.destroy if @swing
    redirect :action => :index  
  end
  
  def delete_all
    @swings = Swing.find(:all)
    @swings.each do |s|
      s.destroy if s
    end
    redirect '/app'
  end
  
end
