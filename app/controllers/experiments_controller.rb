class ExperimentsController < ApplicationController
  def new
    @character = Character.new
  end

  def forms
    @character = Character.new
  end
end
