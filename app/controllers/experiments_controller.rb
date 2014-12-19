class ExperimentsController < ApplicationController
  def new
    @user = User.new
  end

  def forms
    @user = User.new
  end
end
