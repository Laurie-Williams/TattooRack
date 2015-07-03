# Track Votes with Public Activity
ActsAsVotable::Vote.include PublicActivity::Model
ActsAsVotable::Vote.tracked only: :create,
                            owner: ->(controller, model) { controller && controller.current_user },
                            recipient: ->(controller, model) { model && model.votable.user }