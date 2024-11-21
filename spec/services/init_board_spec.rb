require 'rails_helper'

RSpec.describe InitBoard, type: :service do
  let(:params) do
    ActionController::Parameters.new({
      board: {
        name: 'Test Board',
        email: 'test@example.com',
        width: 5,
        height: 5,
        mines: 5
      }
    })
  end

  describe '#call' do
    it 'creates a new board with the correct attributes' do
      service = InitBoard.new(params)
      board = service.call

      expect(board).to be_persisted
      expect(board.name).to eq('Test Board')
      expect(board.email).to eq('test@example.com')
      expect(board.width).to eq(5)
      expect(board.height).to eq(5)
      expect(board.mines).to eq(5)
      expect(board.mine_positions.size).to eq(5)
    end

    it 'does not save the board if invalid' do
      invalid_params = ActionController::Parameters.new({
        board: {
          name: '',
          email: 'invalid',
          width: 0,
          height: 0,
          mines: 0
        }
      })
      service = InitBoard.new(invalid_params)
      board = service.call

      expect(board).not_to be_persisted
      expect(board.errors).not_to be_empty
    end
  end

  describe '#generate_mine_positions' do
    it 'generates the correct number of unique mine positions' do
      service = InitBoard.new(params)
      mine_positions = service.send(:generate_mine_positions)

      expect(mine_positions.size).to eq(5)
      expect(mine_positions.uniq.size).to eq(5)
      mine_positions.each do |position|
        expect(position).to be_a(Array)
        expect(position.size).to eq(2)
        expect(position[0]).to be_between(0, 4)
        expect(position[1]).to be_between(0, 4)
      end
    end
  end
end