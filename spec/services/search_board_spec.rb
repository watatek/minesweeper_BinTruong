require 'rails_helper'

RSpec.describe SearchBoard, type: :service do
  let!(:board1) { create(:board, email: 'test1@example.com', name: 'Board 1', mines: 10, created_at: '2023-01-01') }
  let!(:board2) { create(:board, email: 'test2@example.com', name: 'Board 2', mines: 20, created_at: '2023-02-01') }
  let!(:board3) { create(:board, email: 'test3@example.com', name: 'Board 3', mines: 30, created_at: '2023-03-01') }

  describe '#call' do
    it 'returns all boards when no filters are applied' do
      params = {}
      service = SearchBoard.new(params)
      result = service.call

      expect(result).to include(board1, board2, board3)
    end

    it 'filters boards by email' do
      params = { email: 'test1@example.com' }
      service = SearchBoard.new(params)
      result = service.call

      expect(result).to include(board1)
      expect(result).not_to include(board2, board3)
    end

    it 'filters boards by name' do
      params = { name: 'Board 2' }
      service = SearchBoard.new(params)
      result = service.call

      expect(result).to include(board2)
      expect(result).not_to include(board1, board3)
    end

    it 'filters boards by mines' do
      params = { mines: '20' }
      service = SearchBoard.new(params)
      result = service.call

      expect(result).to include(board2)
      expect(result).not_to include(board1, board3)
    end

    it 'filters boards by created_at date range' do
      params = { start_date: '2023-01-01', end_date: '2023-02-01' }
      service = SearchBoard.new(params)
      result = service.call

      expect(result).to include(board1, board2)
      expect(result).not_to include(board3)
    end

    it 'applies multiple filters' do
      params = { email: 'test2@example.com', name: 'Board 2', mines: '20', start_date: '2023-01-01', end_date: '2023-02-01' }
      service = SearchBoard.new(params)
      result = service.call

      expect(result).to include(board2)
      expect(result).not_to include(board1, board3)
    end
  end
end