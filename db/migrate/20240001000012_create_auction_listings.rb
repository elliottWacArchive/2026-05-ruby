class CreateAuctionListings < ActiveRecord::Migration[8.1]
  def change
    create_table :auction_listings do |t|
      t.references :inventory, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: { to_table: :characters }
      t.references :buyer, foreign_key: { to_table: :characters }
      t.integer :price, null: false
      t.string :status, null: false, default: "active"  # active, sold, cancelled
      t.timestamps
    end
  end
end
