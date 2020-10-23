class CreateBanners < SpreeExtension::Migration[4.2]
  def self.up
    create_table :spree_banners do |t|
      t.string :title, require: true
      t.text :description, require: true
      t.string :link, require: true
      t.datetime :start, require: true
      t.datetime :end
      t.integer :location_page, require: true
      t.string :location_type, require: true
      t.integer :old_price
      t.integer :new_price
      t.integer :position
      t.boolean :visible, default: true
      t.integer :views
      t.timestamps
    end

    add_index :spree_banners, [:title], name: 'index_spree_banners_on_title'
    add_index :spree_banners, [:start], name: 'index_spree_banners_on_start'
    add_index :spree_banners, [:end], name: 'index_spree_banners_on_end'
  end

  def self.down
    drop_table :spree_banners
  end
end
