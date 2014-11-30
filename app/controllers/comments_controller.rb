class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:body))
    @comment.user_id = current_user.id
    
    if @comment.save
      redirect_to [@topic, @post], notice: "Comment was saved successfully."
    else
      redirect_to [@topic, @post], notice: "Error saving comment."
    end
  end
end

