class CreateTickersCiks < ActiveRecord::Migration[7.0]
  def change
    create_table :ticker_ciks do |t|
      t.string :tickers, array: true, default: []
      t.string :cik, null: false

      t.timestamps
    end

    add_index :ticker_ciks, :tickers, using: 'gin'
    add_index :ticker_ciks, :cik, unique: true
    add_index :ticker_ciks, %i[cik tickers], unique: true
  end
end
