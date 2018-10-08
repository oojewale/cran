class CreatePackageMaintainerJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :packages, :maintainers do |t|
      t.index :package_id
      t.index :maintainer_id
    end
  end
end
