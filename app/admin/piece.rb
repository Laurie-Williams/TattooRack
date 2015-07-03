ActiveAdmin.register Piece do
  scope :published

  index do
    column :image do |piece|
      image_tag piece.image_url
    end
    column :image_url
    column :category
    column :user
    column :tag_list
    column :cached_votes_up
    column :created_at
    actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

end
