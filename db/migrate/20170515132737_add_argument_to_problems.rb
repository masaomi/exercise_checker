class AddArgumentToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :arguments, :string
  end
end
