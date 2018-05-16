class User < ActiveRecord::Base
  serialize :sources
  serialize :results
  serialize :comments
  serialize :scores
end
