class LikesController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @like = @post.likes.build(user: current_user)
      if @like.save
        redirect_to @post, notice: 'You liked this post.'
      else
        redirect_to @post, alert: 'Unable to like this post.'
      end
    end
  
    def destroy
      @post = Post.find(params[:post_id])
      @like = @post.likes.find_by(user: current_user)
      @like.destroy
      redirect_to @post, notice: 'Like removed.'
    end
  end
  
