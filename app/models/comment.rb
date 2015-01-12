# class for comment
class Comment < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  def edit_content(data)
    self.content = data[:content]
    save
  end
end
