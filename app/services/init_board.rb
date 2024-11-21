class InitBoard
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    board = Board.new(board_params)
    if board.valid?
      board.mine_positions = generate_mine_positions
      board.save
    end

    board
  end

  private

  def generate_mine_positions
    width = board_params[:width].to_i
    height = board_params[:height].to_i
    mines = board_params[:mines].to_i
    mine_positions = []
    while mine_positions.size < mines
      position = [rand(width), rand(height)]
      mine_positions << position unless mine_positions.include?(position)
    end
    mine_positions
  end

  def board_params
    params.require(:board).permit(:name, :email, :width, :height, :mines)
  end
end