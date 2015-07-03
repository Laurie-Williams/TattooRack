class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment
  include PublicActivity::Model

  belongs_to :commentable, polymorphic: true, counter_cache: true
  default_scope -> { order('created_at ASC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
  acts_as_commentable
  tracked only: :create,
          owner: ->(controller, model) { controller && controller.current_user },
          recipient: ->(controller, model) { model && model.commentable.user }
end
