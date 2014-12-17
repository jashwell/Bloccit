class CommentsController < ApplicationController
  respond_to :html, :js
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
    else
      flash[:error] = "Comment couldn't be deleted."
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end
  end
end

