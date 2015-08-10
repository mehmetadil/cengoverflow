class CreateJoinQuestionTag < ActiveRecord::Migration
  def change
    create_table :join_question_tags do |t|
      t.string :question
      t.string :tag
    end
  end
end
