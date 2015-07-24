ActiveAdmin.register User do
  index do
    column :id
    column :avatar do |user|
      image_tag user.avatar_url
    end
    column :username
    column :email
    column :name
    column :created_at
    column :last_sign_in_at
    column :current_sign_in_ip
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
