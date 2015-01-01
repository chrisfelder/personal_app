class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def contact
  end
  
  def experiments
  end

  def news
  end

  def cv
    @page_background = "cv_background"
  end

  def projects
  end

  def about
  end
end
