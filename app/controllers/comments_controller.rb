class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:body))
    @comment.user_id = current_user.id
    
    if @comment.save
      redirect_to [@post.topic, @post], notice: "Comment was saved successfully."
    else
      redirect_to [@post.topic, @post], notice: "Error saving comment."
    end
  end

   def destroy
     @post = Post.find(params[:post_id])
     @comment = @post.comments.find(params[:id])
     authorize @comment

     if @comment.destroy
       flash[:notice] = "Comment was deleted."
       redirect_to [@post.topic, @post]
     else
       flash[:error] = "Comment couldn't be deleted."
       redirect_to [@post.topic, @post]
     end
   end
end

