class AddJobToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :job, :string
  end
end
