class SearchBoard
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    @boards = Board.all
    @boards = @boards.where('email LIKE ?', "%#{params[:email].strip}%") if params[:email].present?
    @boards = @boards.where('name LIKE ?', "%#{params[:name].strip}%") if params[:name].present?
    @boards = @boards.where('mines = ?', params[:mines].strip) if params[:mines].present?
    if params[:start_date].present? && params[:end_date].present?
      @boards = @boards.where(created_at: params[:start_date]..params[:end_date])
    end
    @boards.page(params[:page])
  end
end