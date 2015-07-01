class UsersIndex < Chewy::Index
  define_type User do
    field :name, :username, :bio
  end


  def self.search(keyword)
    keyword.downcase!
    UsersIndex::User.query(
      multi_match: {
        query: keyword,
        type: :phrase_prefix,
        fields: [:name, :username, :bio]
      }
    )
  end

end