class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show ]

  # GET /boards or /boards.json
  def index
    @boards = SearchBoard.new(params).call
  end

  # GET /boards/1 or /boards/1.json
  def show
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # POST /boards or /boards.json
  def create
    @board = InitBoard.new(params).call

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end
end
