class AddColumnCommentToOffs < ActiveRecord::Migration[5.1]
  def change
    add_column :offs, :comment, :string
  end
end
