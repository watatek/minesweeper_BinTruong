class HomeController < ApplicationController
  def dashboard
    # List the 10 most recent boards
    @last_recent_boards = Board.order(id: :desc).limit(10)
  end
end
