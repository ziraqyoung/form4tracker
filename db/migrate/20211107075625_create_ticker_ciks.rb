class CreateTickerCiks < ActiveRecord::Migration[7.0]
  def change
    create_table :ticker_ciks do |t|
      t.string :cik, null: false
      t.string :tickers, array: true, default: []

      t.timestamps
    end

    add_index :ticker_ciks, :tickers, using: 'gin'
    add_index :ticker_ciks, :cik, unique: true
  end
end
