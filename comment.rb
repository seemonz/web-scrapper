class Comment
  attr_reader :author, :comment

  def initialize(author, comment)
    @author = author
    @comment = comment
  end
end
