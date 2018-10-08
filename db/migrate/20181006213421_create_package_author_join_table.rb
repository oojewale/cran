class CreatePackageAuthorJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :packages, :authors do |t|
      t.index :package_id
      t.index :author_id
    end
  end
end
