class Board < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :width, :height, :mines, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :max_mines

  def generate_board_state
    Array.new(height) do |row|
      Array.new(width) do |col|
        { mine: mine_positions.include?([col, row]) }
      end
    end
  end

  private

  def max_mines
    if width.present? && height.present? && mines.present?
      errors.add(:mines, "can't be greater than the number of cells (#{width * height})") if mines > width * height
    end
  end
end
