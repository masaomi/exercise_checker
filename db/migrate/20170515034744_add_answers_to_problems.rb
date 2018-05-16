class AddAnswersToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :answer_src, :string
    add_column :problems, :answer_out, :string
  end
end
