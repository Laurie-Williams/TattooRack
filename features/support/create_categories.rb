Before do #Execute only once for all features
  @dunit ||= false  # have to define a variable before we can reference its value
  return @dunit if @dunit                  # bail if $dunit TRUE
  Category.create(name: "Tattoo") # otherwise do it.
  Category.create(name: "Flash")
  Category.create(name: "Artwork")
  Category.create(name: "Inspiration")
  @dunit = true                            # don't do it again.
end