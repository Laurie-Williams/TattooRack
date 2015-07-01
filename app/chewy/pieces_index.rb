class PiecesIndex < Chewy::Index
  define_type Piece.published.includes(:tags) do
    field :title, :description
    field :tags, value: ->(piece) { piece.tags.map(&:name) }
  end


  def self.search(keyword)
    keyword.downcase!
    PiecesIndex::Piece.query(
      multi_match: {
        query: keyword,
        type: :phrase_prefix,
        fields: [:title, :description, :tags]
      }
    )
  end

end