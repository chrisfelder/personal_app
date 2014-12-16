class ExperimentsController < ApplicationController
  def new
    @acharacter = Character.new
  end

  def forms
    @character = Character.new
  end
end
